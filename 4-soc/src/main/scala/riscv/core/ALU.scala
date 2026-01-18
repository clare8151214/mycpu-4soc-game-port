// SPDX-License-Identifier: MIT
// MyCPU is freely redistributable under the MIT License. See the file
// "LICENSE" for information on usage and redistribution of this file.

package riscv.core

import chisel3._
import chisel3.util._
import riscv.Parameters

/**
 * ALU function encoding. Maps to RV32I instruction funct3/funct7 combinations.
 *
 * The ALUControl module translates instruction encoding to these operations.
 * Special case 'zero' produces constant 0 for non-ALU instructions that still
 * flow through the execute stage (e.g., stores use ALU for address calculation
 * but don't need a separate zero output).
 */
object ALUFunctions extends ChiselEnum {
  val zero, add, sub, sll, slt, xor, or, and, srl, sra, sltu, mul, mulh, mulhsu, mulhu, div, rem, divu, remu = Value
}

/**
 * Arithmetic Logic Unit: combinational compute engine for the Execute stage.
 *
 * Implements all RV32I integer operations in a single cycle:
 * - Arithmetic: ADD (also used for address calculation), SUB
 * - Logical: AND, OR, XOR (bitwise operations)
 * - Shift: SLL (left), SRL (logical right), SRA (arithmetic right, sign-extends)
 * - Compare: SLT (signed), SLTU (unsigned) - output 1 if op1 < op2, else 0
 *
 * Shift amounts use only lower 5 bits of op2 (RISC-V spec: shamt[4:0]).
 * Comparison results are 1-bit values zero-extended to 32 bits.
 *
 * Critical path: SLT/SLTU comparisons and SRA (requires sign extension logic).
 */
class ALU extends Module {
  val io = IO(new Bundle {
    val func = Input(ALUFunctions())

    val op1 = Input(UInt(Parameters.DataWidth))
    val op2 = Input(UInt(Parameters.DataWidth))

    val result = Output(UInt(Parameters.DataWidth))
  })

  io.result := 0.U
  switch(io.func) {
    is(ALUFunctions.add) {
      io.result := io.op1 + io.op2
    }
    is(ALUFunctions.sub) {
      io.result := io.op1 - io.op2
    }
    is(ALUFunctions.sll) {
      io.result := io.op1 << io.op2(4, 0)
    }
    is(ALUFunctions.slt) {
      io.result := io.op1.asSInt < io.op2.asSInt
    }
    is(ALUFunctions.xor) {
      io.result := io.op1 ^ io.op2
    }
    is(ALUFunctions.or) {
      io.result := io.op1 | io.op2
    }
    is(ALUFunctions.and) {
      io.result := io.op1 & io.op2
    }
    is(ALUFunctions.srl) {
      io.result := io.op1 >> io.op2(4, 0)
    }
    is(ALUFunctions.sra) {
      io.result := (io.op1.asSInt >> io.op2(4, 0)).asUInt
    }
    is(ALUFunctions.sltu) {
      io.result := io.op1 < io.op2
    }
    is(ALUFunctions.mul) {
      io.result := (io.op1 * io.op2)(Parameters.DataBits - 1, 0)
    }
    is(ALUFunctions.mulh) {
      val prod = (io.op1.asSInt * io.op2.asSInt).asUInt
      io.result := prod(63, 32)
    }
    is(ALUFunctions.mulhsu) {
      val op2u = Cat(0.U(1.W), io.op2).asSInt
      val prod = (io.op1.asSInt * op2u).asUInt
      io.result := prod(63, 32)
    }
    is(ALUFunctions.mulhu) {
      val prod = io.op1 * io.op2
      io.result := prod(63, 32)
    }
    is(ALUFunctions.div) {
      val op1Neg    = io.op1(Parameters.DataBits - 1)
      val op2Neg    = io.op2(Parameters.DataBits - 1)
      val op1Abs    = Mux(op1Neg, (~io.op1).asUInt + 1.U, io.op1)
      val op2Abs    = Mux(op2Neg, (~io.op2).asUInt + 1.U, io.op2)
      val divAbs    = op1Abs / op2Abs
      val divSigned = Mux(op1Neg ^ op2Neg, (~divAbs).asUInt + 1.U, divAbs)
      io.result := Mux(io.op2 === 0.U, "hFFFFFFFF".U, divSigned)
    }
    is(ALUFunctions.rem) {
      val op1Neg    = io.op1(Parameters.DataBits - 1)
      val op2Neg    = io.op2(Parameters.DataBits - 1)
      val op1Abs    = Mux(op1Neg, (~io.op1).asUInt + 1.U, io.op1)
      val op2Abs    = Mux(op2Neg, (~io.op2).asUInt + 1.U, io.op2)
      val remAbs    = op1Abs % op2Abs
      val remSigned = Mux(op1Neg, (~remAbs).asUInt + 1.U, remAbs)
      io.result := Mux(io.op2 === 0.U, io.op1, remSigned)
    }
    is(ALUFunctions.divu) {
      io.result := Mux(io.op2 === 0.U, "hFFFFFFFF".U, io.op1 / io.op2)
    }
    is(ALUFunctions.remu) {
      io.result := Mux(io.op2 === 0.U, io.op1, io.op1 % io.op2)
    }
  }
}
