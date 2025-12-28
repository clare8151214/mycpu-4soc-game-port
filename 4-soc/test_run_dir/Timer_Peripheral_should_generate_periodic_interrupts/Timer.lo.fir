FIRRTL version 1.2.0
circuit Timer :
  module Timer :
    input clock : Clock
    input reset : UInt<1>
    input io_bundle_address : UInt<32> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]
    input io_bundle_write_data : UInt<32> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]
    input io_bundle_write_enable : UInt<1> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]
    input io_bundle_write_strobe_0 : UInt<1> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]
    input io_bundle_write_strobe_1 : UInt<1> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]
    input io_bundle_write_strobe_2 : UInt<1> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]
    input io_bundle_write_strobe_3 : UInt<1> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]
    output io_bundle_read_data : UInt<32> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]
    output io_signal_interrupt : UInt<1> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]
    output io_debug_limit : UInt<32> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]
    output io_debug_enabled : UInt<1> @[4-soc/src/main/scala/peripheral/Timer.scala 28:14]

    reg count : UInt<32>, clock with :
      reset => (UInt<1>("h0"), count) @[4-soc/src/main/scala/peripheral/Timer.scala 36:22]
    reg limit : UInt<32>, clock with :
      reset => (UInt<1>("h0"), limit) @[4-soc/src/main/scala/peripheral/Timer.scala 37:22]
    reg enabled : UInt<1>, clock with :
      reset => (UInt<1>("h0"), enabled) @[4-soc/src/main/scala/peripheral/Timer.scala 39:24]
    node _io_signal_interrupt_T = geq(count, limit) @[4-soc/src/main/scala/peripheral/Timer.scala 48:44]
    node _io_signal_interrupt_T_1 = and(enabled, _io_signal_interrupt_T) @[4-soc/src/main/scala/peripheral/Timer.scala 48:34]
    node _count_T = geq(count, limit) @[4-soc/src/main/scala/peripheral/Timer.scala 49:36]
    node _count_T_1 = add(count, UInt<1>("h1")) @[4-soc/src/main/scala/peripheral/Timer.scala 49:57]
    node _count_T_2 = tail(_count_T_1, 1) @[4-soc/src/main/scala/peripheral/Timer.scala 49:57]
    node _count_T_3 = mux(_count_T, UInt<1>("h0"), _count_T_2) @[4-soc/src/main/scala/peripheral/Timer.scala 49:29]
    node _io_bundle_read_data_T = eq(UInt<4>("h8"), io_bundle_address) @[4-soc/src/main/scala/peripheral/Timer.scala 51:59]
    node _io_bundle_read_data_T_1 = mux(_io_bundle_read_data_T, enabled, UInt<1>("h0")) @[4-soc/src/main/scala/peripheral/Timer.scala 51:59]
    node _io_bundle_read_data_T_2 = eq(UInt<3>("h4"), io_bundle_address) @[4-soc/src/main/scala/peripheral/Timer.scala 51:59]
    node _io_bundle_read_data_T_3 = mux(_io_bundle_read_data_T_2, limit, _io_bundle_read_data_T_1) @[4-soc/src/main/scala/peripheral/Timer.scala 51:59]
    node _T = eq(io_bundle_address, UInt<4>("h8")) @[4-soc/src/main/scala/peripheral/Timer.scala 59:28]
    node _T_1 = eq(io_bundle_address, UInt<3>("h4")) @[4-soc/src/main/scala/peripheral/Timer.scala 61:34]
    node _GEN_0 = mux(_T_1, io_bundle_write_data, limit) @[4-soc/src/main/scala/peripheral/Timer.scala 61:54 62:13 37:22]
    node _GEN_1 = mux(_T, io_bundle_write_data, enabled) @[4-soc/src/main/scala/peripheral/Timer.scala 59:49 60:15 39:24]
    node _GEN_2 = mux(_T, limit, _GEN_0) @[4-soc/src/main/scala/peripheral/Timer.scala 37:22 59:49]
    node _GEN_3 = mux(io_bundle_write_enable, _GEN_1, enabled) @[4-soc/src/main/scala/peripheral/Timer.scala 39:24 58:32]
    node _GEN_4 = mux(io_bundle_write_enable, _GEN_2, limit) @[4-soc/src/main/scala/peripheral/Timer.scala 37:22 58:32]
    io_bundle_read_data <= _io_bundle_read_data_T_3 @[4-soc/src/main/scala/peripheral/Timer.scala 51:23]
    io_signal_interrupt <= _io_signal_interrupt_T_1 @[4-soc/src/main/scala/peripheral/Timer.scala 48:23]
    io_debug_limit <= limit @[4-soc/src/main/scala/peripheral/Timer.scala 38:18]
    io_debug_enabled <= enabled @[4-soc/src/main/scala/peripheral/Timer.scala 40:20]
    count <= mux(reset, UInt<32>("h0"), _count_T_3) @[4-soc/src/main/scala/peripheral/Timer.scala 36:{22,22} 49:23]
    limit <= mux(reset, UInt<32>("h5f5e100"), _GEN_4) @[4-soc/src/main/scala/peripheral/Timer.scala 37:{22,22}]
    enabled <= bits(mux(reset, UInt<1>("h1"), _GEN_3), 0, 0) @[4-soc/src/main/scala/peripheral/Timer.scala 39:{24,24}]
