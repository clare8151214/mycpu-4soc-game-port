FIRRTL version 1.2.0
circuit Rx :
  module Rx :
    input clock : Clock
    input reset : UInt<1>
    input io_rxd : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 88:14]
    input io_channel_ready : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 88:14]
    output io_channel_valid : UInt<1> @[4-soc/src/main/scala/peripheral/UART.scala 88:14]
    output io_channel_bits : UInt<8> @[4-soc/src/main/scala/peripheral/UART.scala 88:14]

    reg rxReg_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg_REG) @[4-soc/src/main/scala/peripheral/UART.scala 99:30]
    reg rxReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg) @[4-soc/src/main/scala/peripheral/UART.scala 99:22]
    reg shiftReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), shiftReg) @[4-soc/src/main/scala/peripheral/UART.scala 101:25]
    reg cntReg : UInt<16>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[4-soc/src/main/scala/peripheral/UART.scala 102:25]
    reg bitsReg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), bitsReg) @[4-soc/src/main/scala/peripheral/UART.scala 103:25]
    reg valReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), valReg) @[4-soc/src/main/scala/peripheral/UART.scala 104:25]
    node _T = neq(cntReg, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 106:15]
    node _cntReg_T = sub(cntReg, UInt<1>("h1")) @[4-soc/src/main/scala/peripheral/UART.scala 107:22]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[4-soc/src/main/scala/peripheral/UART.scala 107:22]
    node _T_1 = neq(bitsReg, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 108:22]
    node _shiftReg_T = shr(shiftReg, 1) @[4-soc/src/main/scala/peripheral/UART.scala 110:37]
    node _shiftReg_T_1 = cat(rxReg, _shiftReg_T) @[4-soc/src/main/scala/peripheral/UART.scala 110:20]
    node _bitsReg_T = sub(bitsReg, UInt<1>("h1")) @[4-soc/src/main/scala/peripheral/UART.scala 111:25]
    node _bitsReg_T_1 = tail(_bitsReg_T, 1) @[4-soc/src/main/scala/peripheral/UART.scala 111:25]
    node _T_2 = eq(bitsReg, UInt<1>("h1")) @[4-soc/src/main/scala/peripheral/UART.scala 112:18]
    node _GEN_0 = mux(_T_2, UInt<1>("h1"), valReg) @[4-soc/src/main/scala/peripheral/UART.scala 112:27 113:14 104:25]
    node _T_3 = eq(rxReg, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 115:20]
    node _T_4 = eq(valReg, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/UART.scala 115:31]
    node _T_5 = and(_T_3, _T_4) @[4-soc/src/main/scala/peripheral/UART.scala 115:28]
    node _GEN_1 = mux(_T_5, UInt<4>("he"), cntReg) @[4-soc/src/main/scala/peripheral/UART.scala 115:40 118:13 102:25]
    node _GEN_2 = mux(_T_5, UInt<4>("h8"), bitsReg) @[4-soc/src/main/scala/peripheral/UART.scala 115:40 119:13 103:25]
    node _GEN_3 = mux(_T_1, UInt<4>("h9"), _GEN_1) @[4-soc/src/main/scala/peripheral/UART.scala 108:31 109:14]
    node _GEN_4 = mux(_T_1, _shiftReg_T_1, shiftReg) @[4-soc/src/main/scala/peripheral/UART.scala 108:31 110:14 101:25]
    node _GEN_5 = mux(_T_1, _bitsReg_T_1, _GEN_2) @[4-soc/src/main/scala/peripheral/UART.scala 108:31 111:14]
    node _GEN_6 = mux(_T_1, _GEN_0, valReg) @[4-soc/src/main/scala/peripheral/UART.scala 104:25 108:31]
    node _GEN_7 = mux(_T, _cntReg_T_1, _GEN_3) @[4-soc/src/main/scala/peripheral/UART.scala 106:24 107:12]
    node _GEN_8 = mux(_T, shiftReg, _GEN_4) @[4-soc/src/main/scala/peripheral/UART.scala 106:24 101:25]
    node _GEN_9 = mux(_T, bitsReg, _GEN_5) @[4-soc/src/main/scala/peripheral/UART.scala 106:24 103:25]
    node _GEN_10 = mux(_T, valReg, _GEN_6) @[4-soc/src/main/scala/peripheral/UART.scala 106:24 104:25]
    node _T_6 = and(valReg, io_channel_ready) @[4-soc/src/main/scala/peripheral/UART.scala 122:15]
    node _GEN_11 = mux(_T_6, UInt<1>("h0"), _GEN_10) @[4-soc/src/main/scala/peripheral/UART.scala 122:36 123:12]
    io_channel_valid <= valReg @[4-soc/src/main/scala/peripheral/UART.scala 127:20]
    io_channel_bits <= shiftReg @[4-soc/src/main/scala/peripheral/UART.scala 126:20]
    rxReg_REG <= mux(reset, UInt<1>("h1"), io_rxd) @[4-soc/src/main/scala/peripheral/UART.scala 99:{30,30,30}]
    rxReg <= mux(reset, UInt<1>("h1"), rxReg_REG) @[4-soc/src/main/scala/peripheral/UART.scala 99:{22,22,22}]
    shiftReg <= mux(reset, UInt<8>("h0"), _GEN_8) @[4-soc/src/main/scala/peripheral/UART.scala 101:{25,25}]
    cntReg <= mux(reset, UInt<16>("h0"), _GEN_7) @[4-soc/src/main/scala/peripheral/UART.scala 102:{25,25}]
    bitsReg <= mux(reset, UInt<4>("h0"), _GEN_9) @[4-soc/src/main/scala/peripheral/UART.scala 103:{25,25}]
    valReg <= mux(reset, UInt<1>("h0"), _GEN_11) @[4-soc/src/main/scala/peripheral/UART.scala 104:{25,25}]
