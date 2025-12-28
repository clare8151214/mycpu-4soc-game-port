FIRRTL version 1.2.0
circuit BufferedTx :
  module Tx :
    input clock : Clock
    input reset : UInt<1>
    output io_txd : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 44:14]
    output io_channel_ready : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 44:14]
    input io_channel_valid : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 44:14]
    input io_channel_bits : UInt<8> @[4-soc/src/main/scala/peripheral/UART.scala 44:14]

    reg shiftReg : UInt<11>, clock with :
      reset => (UInt<1>("h0"), shiftReg) @[4-soc/src/main/scala/peripheral/UART.scala 52:25]
    reg cntReg : UInt<16>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[4-soc/src/main/scala/peripheral/UART.scala 53:25]
    reg bitsReg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), bitsReg) @[4-soc/src/main/scala/peripheral/UART.scala 54:25]
    node _io_channel_ready_T = eq(cntReg, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 56:31]
    node _io_channel_ready_T_1 = eq(bitsReg, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 56:52]
    node _io_channel_ready_T_2 = and(_io_channel_ready_T, _io_channel_ready_T_1) @[4-soc/src/main/scala/peripheral/UART.scala 56:40]
    node _io_txd_T = bits(shiftReg, 0, 0) @[4-soc/src/main/scala/peripheral/UART.scala 57:31]
    node _T = eq(cntReg, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 59:15]
    node _T_1 = neq(bitsReg, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 61:18]
    node shift = shr(shiftReg, 1) @[4-soc/src/main/scala/peripheral/UART.scala 62:28]
    node _shiftReg_T = bits(shift, 9, 0) @[4-soc/src/main/scala/peripheral/UART.scala 63:33]
    node _shiftReg_T_1 = cat(UInt<1>("h1"), _shiftReg_T) @[4-soc/src/main/scala/peripheral/UART.scala 63:22]
    node _bitsReg_T = sub(bitsReg, UInt<1>("h1")) @[4-soc/src/main/scala/peripheral/UART.scala 64:27]
    node _bitsReg_T_1 = tail(_bitsReg_T, 1) @[4-soc/src/main/scala/peripheral/UART.scala 64:27]
    node _shiftReg_T_2 = cat(UInt<2>("h3"), io_channel_bits) @[4-soc/src/main/scala/peripheral/UART.scala 69:28]
    node _shiftReg_T_3 = cat(_shiftReg_T_2, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 69:24]
    node _GEN_0 = mux(io_channel_valid, _shiftReg_T_3, UInt<11>("h7ff")) @[4-soc/src/main/scala/peripheral/UART.scala 66:30 69:18 72:18]
    node _GEN_1 = mux(io_channel_valid, UInt<4>("hb"), bitsReg) @[4-soc/src/main/scala/peripheral/UART.scala 66:30 70:18 54:25]
    node _GEN_2 = mux(_T_1, _shiftReg_T_1, _GEN_0) @[4-soc/src/main/scala/peripheral/UART.scala 61:27 63:16]
    node _GEN_3 = mux(_T_1, _bitsReg_T_1, _GEN_1) @[4-soc/src/main/scala/peripheral/UART.scala 61:27 64:16]
    node _cntReg_T = sub(cntReg, UInt<1>("h1")) @[4-soc/src/main/scala/peripheral/UART.scala 76:22]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[4-soc/src/main/scala/peripheral/UART.scala 76:22]
    node _GEN_4 = mux(_T, UInt<4>("h9"), _cntReg_T_1) @[4-soc/src/main/scala/peripheral/UART.scala 59:24 60:12 76:12]
    node _GEN_5 = mux(_T, _GEN_2, shiftReg) @[4-soc/src/main/scala/peripheral/UART.scala 59:24 52:25]
    node _GEN_6 = mux(_T, _GEN_3, bitsReg) @[4-soc/src/main/scala/peripheral/UART.scala 59:24 54:25]
    io_txd <= _io_txd_T @[4-soc/src/main/scala/peripheral/UART.scala 57:20]
    io_channel_ready <= _io_channel_ready_T_2 @[4-soc/src/main/scala/peripheral/UART.scala 56:20]
    shiftReg <= mux(reset, UInt<11>("h7ff"), _GEN_5) @[4-soc/src/main/scala/peripheral/UART.scala 52:{25,25}]
    cntReg <= mux(reset, UInt<16>("h0"), _GEN_4) @[4-soc/src/main/scala/peripheral/UART.scala 53:{25,25}]
    bitsReg <= mux(reset, UInt<4>("h0"), _GEN_6) @[4-soc/src/main/scala/peripheral/UART.scala 54:{25,25}]

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

  module BufferedTx :
    input clock : Clock
    input reset : UInt<1>
    output io_txd : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 163:14]
    output io_channel_ready : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 163:14]
    input io_channel_valid : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 163:14]
    input io_channel_bits : UInt<8> @[4-soc/src/main/scala/peripheral/UART.scala 163:14]

    inst tx of Tx @[4-soc/src/main/scala/peripheral/UART.scala 167:19]
    inst buf of Buffer @[4-soc/src/main/scala/peripheral/UART.scala 168:19]
    io_txd <= tx.io_txd @[4-soc/src/main/scala/peripheral/UART.scala 172:10]
    io_channel_ready <= buf.io_in_ready @[4-soc/src/main/scala/peripheral/UART.scala 170:13]
    tx.clock <= clock
    tx.reset <= reset
    tx.io_channel_valid <= buf.io_out_valid @[4-soc/src/main/scala/peripheral/UART.scala 171:17]
    tx.io_channel_bits <= buf.io_out_bits @[4-soc/src/main/scala/peripheral/UART.scala 171:17]
    buf.clock <= clock
    buf.reset <= reset
    buf.io_in_valid <= io_channel_valid @[4-soc/src/main/scala/peripheral/UART.scala 170:13]
    buf.io_in_bits <= io_channel_bits @[4-soc/src/main/scala/peripheral/UART.scala 170:13]
    buf.io_out_ready <= tx.io_channel_ready @[4-soc/src/main/scala/peripheral/UART.scala 171:17]
