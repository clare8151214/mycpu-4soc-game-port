FIRRTL version 1.2.0
circuit Buffer :
  module Buffer :
    input clock : Clock
    input reset : UInt<1>
    output io_in_ready : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
    input io_in_valid : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
    input io_in_bits : UInt<8> @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
    input io_out_ready : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
    output io_out_valid : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
    output io_out_bits : UInt<8> @[4-soc/src/main/scala/peripheral/UART.scala 134:14]

    reg stateReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[4-soc/src/main/scala/peripheral/UART.scala 140:37]
    reg dataReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[4-soc/src/main/scala/peripheral/UART.scala 141:37]
    node _io_in_ready_T = eq(stateReg, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 143:28]
    node _io_out_valid_T = eq(stateReg, UInt<1>("h1")) @[4-soc/src/main/scala/peripheral/UART.scala 144:28]
    node _T = eq(stateReg, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 146:17]
    node _GEN_0 = mux(io_in_valid, io_in_bits, dataReg) @[4-soc/src/main/scala/peripheral/UART.scala 147:23 148:16 141:37]
    node _GEN_1 = mux(io_in_valid, UInt<1>("h1"), stateReg) @[4-soc/src/main/scala/peripheral/UART.scala 147:23 149:16 140:37]
    node _GEN_2 = mux(io_out_ready, UInt<1>("h0"), stateReg) @[4-soc/src/main/scala/peripheral/UART.scala 152:24 153:16 140:37]
    node _GEN_3 = mux(_T, _GEN_0, dataReg) @[4-soc/src/main/scala/peripheral/UART.scala 146:28 141:37]
    node _GEN_4 = mux(_T, _GEN_1, _GEN_2) @[4-soc/src/main/scala/peripheral/UART.scala 146:28]
    io_in_ready <= _io_in_ready_T @[4-soc/src/main/scala/peripheral/UART.scala 143:16]
    io_out_valid <= _io_out_valid_T @[4-soc/src/main/scala/peripheral/UART.scala 144:16]
    io_out_bits <= dataReg @[4-soc/src/main/scala/peripheral/UART.scala 156:15]
    stateReg <= mux(reset, UInt<1>("h0"), _GEN_4) @[4-soc/src/main/scala/peripheral/UART.scala 140:{37,37}]
    dataReg <= mux(reset, UInt<8>("h0"), _GEN_3) @[4-soc/src/main/scala/peripheral/UART.scala 141:{37,37}]
