module AXI4LiteSlave(
  input         clock,
  input         reset,
  input         io_channels_write_address_channel_AWVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_channels_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input  [31:0] io_channels_write_address_channel_AWADDR, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input         io_channels_write_data_channel_WVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_channels_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input  [31:0] io_channels_write_data_channel_WDATA, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input  [3:0]  io_channels_write_data_channel_WSTRB, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_channels_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input         io_channels_write_response_channel_BREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input         io_channels_read_address_channel_ARVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_channels_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input  [31:0] io_channels_read_address_channel_ARADDR, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_channels_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input         io_channels_read_data_channel_RREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output [31:0] io_channels_read_data_channel_RDATA, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output [31:0] io_bundle_address, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_bundle_read, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input  [31:0] io_bundle_read_data, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input         io_bundle_read_valid, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_bundle_write, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output [31:0] io_bundle_write_data, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_bundle_write_strobe_0, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_bundle_write_strobe_1, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_bundle_write_strobe_2, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_bundle_write_strobe_3 // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 136:22]
  reg [31:0] addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 138:21]
  reg  read; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 142:21]
  reg [31:0] read_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 144:26]
  reg  ARREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 147:24]
  reg  RVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 149:23]
  reg  write; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 155:22]
  reg [31:0] write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 157:27]
  reg  write_strobe_0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
  reg  write_strobe_1; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
  reg  write_strobe_2; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
  reg  write_strobe_3; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
  reg  AWREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 162:24]
  reg  WREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 164:23]
  reg  BVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 166:23]
  wire  _GEN_1 = io_channels_write_address_channel_AWVALID | AWREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 180:61 183:17 162:24]
  wire  _GEN_3 = io_channels_read_address_channel_ARVALID | ARREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 176:54 179:17 147:24]
  wire  _GEN_7 = io_channels_read_address_channel_ARVALID & ARREADY | read; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 188:65 192:17 142:21]
  wire [31:0] _GEN_9 = io_bundle_read_valid ? io_bundle_read_data : read_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 198:34 200:19 144:26]
  wire  _GEN_10 = io_bundle_read_valid | RVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 198:34 201:19 149:23]
  wire  _GEN_12 = io_bundle_read_valid ? 1'h0 : read; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 198:34 203:19 142:21]
  wire  _GEN_13 = RVALID & io_channels_read_data_channel_RREADY ? 1'h0 : _GEN_10; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 206:60 208:16]
  wire [2:0] _GEN_14 = RVALID & io_channels_read_data_channel_RREADY ? 3'h0 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 206:60 209:16 136:22]
  wire [31:0] _GEN_15 = io_channels_write_address_channel_AWVALID & AWREADY ? io_channels_write_address_channel_AWADDR
     : addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 214:66 216:17 138:21]
  wire  _GEN_16 = io_channels_write_address_channel_AWVALID & AWREADY ? 1'h0 : AWREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 214:66 217:17 162:24]
  wire  _GEN_17 = io_channels_write_address_channel_AWVALID & AWREADY | WREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 214:66 218:17 164:23]
  wire [2:0] _GEN_18 = io_channels_write_address_channel_AWVALID & AWREADY ? 3'h4 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 214:66 219:17 136:22]
  wire [31:0] _GEN_19 = io_channels_write_data_channel_WVALID & WREADY ? io_channels_write_data_channel_WDATA :
    write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 224:61 226:22 157:27]
  wire  _GEN_20 = io_channels_write_data_channel_WVALID & WREADY ? io_channels_write_data_channel_WSTRB[0] :
    write_strobe_0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 224:61 227:22 159:29]
  wire  _GEN_21 = io_channels_write_data_channel_WVALID & WREADY ? io_channels_write_data_channel_WSTRB[1] :
    write_strobe_1; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 224:61 227:22 159:29]
  wire  _GEN_22 = io_channels_write_data_channel_WVALID & WREADY ? io_channels_write_data_channel_WSTRB[2] :
    write_strobe_2; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 224:61 227:22 159:29]
  wire  _GEN_23 = io_channels_write_data_channel_WVALID & WREADY ? io_channels_write_data_channel_WSTRB[3] :
    write_strobe_3; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 224:61 227:22 159:29]
  wire  _GEN_24 = io_channels_write_data_channel_WVALID & WREADY ? 1'h0 : WREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 224:61 228:22 164:23]
  wire  _GEN_25 = io_channels_write_data_channel_WVALID & WREADY | write; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 155:22 224:61 229:22]
  wire [2:0] _GEN_26 = io_channels_write_data_channel_WVALID & WREADY ? 3'h5 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 136:22 224:61 230:22]
  wire  _GEN_27 = BVALID & io_channels_write_response_channel_BREADY ? 1'h0 : 1'h1; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 236:14 239:65 241:16]
  wire [2:0] _GEN_28 = BVALID & io_channels_write_response_channel_BREADY ? 3'h0 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 239:65 242:16 136:22]
  wire  _GEN_29 = 3'h5 == state ? 1'h0 : write; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 235:14 155:22]
  wire  _GEN_30 = 3'h5 == state ? _GEN_27 : BVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 166:23]
  wire [2:0] _GEN_32 = 3'h5 == state ? _GEN_28 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 136:22]
  wire [31:0] _GEN_33 = 3'h4 == state ? _GEN_19 : write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 157:27]
  wire  _GEN_34 = 3'h4 == state ? _GEN_20 : write_strobe_0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 159:29]
  wire  _GEN_35 = 3'h4 == state ? _GEN_21 : write_strobe_1; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 159:29]
  wire  _GEN_36 = 3'h4 == state ? _GEN_22 : write_strobe_2; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 159:29]
  wire  _GEN_37 = 3'h4 == state ? _GEN_23 : write_strobe_3; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 159:29]
  wire  _GEN_38 = 3'h4 == state ? _GEN_24 : WREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 164:23]
  wire  _GEN_39 = 3'h4 == state ? _GEN_25 : _GEN_29; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
  wire [2:0] _GEN_40 = 3'h4 == state ? _GEN_26 : _GEN_32; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
  wire  _GEN_41 = 3'h4 == state ? BVALID : _GEN_30; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 166:23]
  wire [31:0] _GEN_43 = 3'h3 == state ? _GEN_15 : addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 138:21]
  wire  _GEN_44 = 3'h3 == state ? _GEN_16 : AWREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 162:24]
  wire  _GEN_45 = 3'h3 == state ? _GEN_17 : _GEN_38; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
  wire [2:0] _GEN_46 = 3'h3 == state ? _GEN_18 : _GEN_40; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
  wire [31:0] _GEN_47 = 3'h3 == state ? write_data : _GEN_33; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 157:27]
  wire  _GEN_48 = 3'h3 == state ? write_strobe_0 : _GEN_34; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 159:29]
  wire  _GEN_49 = 3'h3 == state ? write_strobe_1 : _GEN_35; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 159:29]
  wire  _GEN_50 = 3'h3 == state ? write_strobe_2 : _GEN_36; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 159:29]
  wire  _GEN_51 = 3'h3 == state ? write_strobe_3 : _GEN_37; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 159:29]
  wire  _GEN_52 = 3'h3 == state ? write : _GEN_39; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 155:22]
  wire  _GEN_53 = 3'h3 == state ? BVALID : _GEN_41; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 166:23]
  assign io_channels_write_address_channel_AWREADY = AWREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 163:45]
  assign io_channels_write_data_channel_WREADY = WREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 165:41]
  assign io_channels_write_response_channel_BVALID = BVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 167:45]
  assign io_channels_read_address_channel_ARREADY = ARREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 148:44]
  assign io_channels_read_data_channel_RVALID = RVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 150:40]
  assign io_channels_read_data_channel_RDATA = read_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 145:39]
  assign io_bundle_address = addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 139:21]
  assign io_bundle_read = read; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 143:18]
  assign io_bundle_write = write; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 156:19]
  assign io_bundle_write_data = write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 158:24]
  assign io_bundle_write_strobe_0 = write_strobe_0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 160:26]
  assign io_bundle_write_strobe_1 = write_strobe_1; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 160:26]
  assign io_bundle_write_strobe_2 = write_strobe_2; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 160:26]
  assign io_bundle_write_strobe_3 = write_strobe_3; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 160:26]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 136:22]
      state <= 3'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 136:22]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (io_channels_read_address_channel_ARVALID) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 176:54]
        state <= 3'h1; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 178:17]
      end else if (io_channels_write_address_channel_AWVALID) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 180:61]
        state <= 3'h3; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 182:17]
      end
    end else if (3'h1 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (io_channels_read_address_channel_ARVALID & ARREADY) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 188:65]
        state <= 3'h2; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 193:17]
      end
    end else if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      state <= _GEN_14;
    end else begin
      state <= _GEN_46;
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 138:21]
      addr <= 32'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 138:21]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (3'h1 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (io_channels_read_address_channel_ARVALID & ARREADY) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 188:65]
          addr <= io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 190:17]
        end
      end else if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        addr <= _GEN_43;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 142:21]
      read <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 142:21]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      read <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 173:13]
    end else if (3'h1 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      read <= _GEN_7;
    end else if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      read <= _GEN_12;
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 144:26]
      read_data <= 32'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 144:26]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          read_data <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 147:24]
      ARREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 147:24]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      ARREADY <= _GEN_3;
    end else if (3'h1 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (io_channels_read_address_channel_ARVALID & ARREADY) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 188:65]
        ARREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 191:17]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 149:23]
      RVALID <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 149:23]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          RVALID <= _GEN_13;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 155:22]
      write <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 155:22]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      write <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 174:13]
    end else if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        write <= _GEN_52;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 157:27]
      write_data <= 32'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 157:27]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          write_data <= _GEN_47;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
      write_strobe_0 <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          write_strobe_0 <= _GEN_48;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
      write_strobe_1 <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          write_strobe_1 <= _GEN_49;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
      write_strobe_2 <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          write_strobe_2 <= _GEN_50;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
      write_strobe_3 <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 159:29]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          write_strobe_3 <= _GEN_51;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 162:24]
      AWREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 162:24]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(io_channels_read_address_channel_ARVALID)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 176:54]
        AWREADY <= _GEN_1;
      end
    end else if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        AWREADY <= _GEN_44;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 164:23]
      WREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 164:23]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          WREADY <= _GEN_45;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 166:23]
      BVALID <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 166:23]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          BVALID <= _GEN_53;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  addr = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  read = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  read_data = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  ARREADY = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  RVALID = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  write = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  write_data = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  write_strobe_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  write_strobe_1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  write_strobe_2 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  write_strobe_3 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  AWREADY = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  WREADY = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  BVALID = _RAND_14[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXI4LiteSlave_1(
  input         clock,
  input         reset,
  input         io_channels_write_address_channel_AWVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_channels_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input  [7:0]  io_channels_write_address_channel_AWADDR, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input         io_channels_write_data_channel_WVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_channels_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input  [31:0] io_channels_write_data_channel_WDATA, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_channels_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input         io_channels_write_response_channel_BREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input         io_channels_read_address_channel_ARVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_channels_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input  [7:0]  io_channels_read_address_channel_ARADDR, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_channels_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input         io_channels_read_data_channel_RREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output [31:0] io_channels_read_data_channel_RDATA, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output [7:0]  io_bundle_address, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_bundle_read, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input  [31:0] io_bundle_read_data, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  input         io_bundle_read_valid, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output        io_bundle_write, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
  output [31:0] io_bundle_write_data // @[4-soc/src/main/scala/bus/AXI4Lite.scala 131:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 136:22]
  reg [7:0] addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 138:21]
  reg  read; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 142:21]
  reg [31:0] read_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 144:26]
  reg  ARREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 147:24]
  reg  RVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 149:23]
  reg  write; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 155:22]
  reg [31:0] write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 157:27]
  reg  AWREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 162:24]
  reg  WREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 164:23]
  reg  BVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 166:23]
  wire  _GEN_1 = io_channels_write_address_channel_AWVALID | AWREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 180:61 183:17 162:24]
  wire  _GEN_3 = io_channels_read_address_channel_ARVALID | ARREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 176:54 179:17 147:24]
  wire  _GEN_7 = io_channels_read_address_channel_ARVALID & ARREADY | read; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 188:65 192:17 142:21]
  wire [31:0] _GEN_9 = io_bundle_read_valid ? io_bundle_read_data : read_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 198:34 200:19 144:26]
  wire  _GEN_10 = io_bundle_read_valid | RVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 198:34 201:19 149:23]
  wire  _GEN_12 = io_bundle_read_valid ? 1'h0 : read; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 198:34 203:19 142:21]
  wire  _GEN_13 = RVALID & io_channels_read_data_channel_RREADY ? 1'h0 : _GEN_10; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 206:60 208:16]
  wire [2:0] _GEN_14 = RVALID & io_channels_read_data_channel_RREADY ? 3'h0 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 206:60 209:16 136:22]
  wire [7:0] _GEN_15 = io_channels_write_address_channel_AWVALID & AWREADY ? io_channels_write_address_channel_AWADDR :
    addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 214:66 216:17 138:21]
  wire  _GEN_16 = io_channels_write_address_channel_AWVALID & AWREADY ? 1'h0 : AWREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 214:66 217:17 162:24]
  wire  _GEN_17 = io_channels_write_address_channel_AWVALID & AWREADY | WREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 214:66 218:17 164:23]
  wire [2:0] _GEN_18 = io_channels_write_address_channel_AWVALID & AWREADY ? 3'h4 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 214:66 219:17 136:22]
  wire [31:0] _GEN_19 = io_channels_write_data_channel_WVALID & WREADY ? io_channels_write_data_channel_WDATA :
    write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 224:61 226:22 157:27]
  wire  _GEN_24 = io_channels_write_data_channel_WVALID & WREADY ? 1'h0 : WREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 224:61 228:22 164:23]
  wire  _GEN_25 = io_channels_write_data_channel_WVALID & WREADY | write; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 155:22 224:61 229:22]
  wire [2:0] _GEN_26 = io_channels_write_data_channel_WVALID & WREADY ? 3'h5 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 136:22 224:61 230:22]
  wire  _GEN_27 = BVALID & io_channels_write_response_channel_BREADY ? 1'h0 : 1'h1; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 236:14 239:65 241:16]
  wire [2:0] _GEN_28 = BVALID & io_channels_write_response_channel_BREADY ? 3'h0 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 239:65 242:16 136:22]
  wire  _GEN_29 = 3'h5 == state ? 1'h0 : write; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 235:14 155:22]
  wire  _GEN_30 = 3'h5 == state ? _GEN_27 : BVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 166:23]
  wire [2:0] _GEN_32 = 3'h5 == state ? _GEN_28 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 136:22]
  wire [31:0] _GEN_33 = 3'h4 == state ? _GEN_19 : write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 157:27]
  wire  _GEN_38 = 3'h4 == state ? _GEN_24 : WREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 164:23]
  wire  _GEN_39 = 3'h4 == state ? _GEN_25 : _GEN_29; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
  wire [2:0] _GEN_40 = 3'h4 == state ? _GEN_26 : _GEN_32; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
  wire  _GEN_41 = 3'h4 == state ? BVALID : _GEN_30; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 166:23]
  wire [7:0] _GEN_43 = 3'h3 == state ? _GEN_15 : addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 138:21]
  wire  _GEN_44 = 3'h3 == state ? _GEN_16 : AWREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 162:24]
  wire  _GEN_45 = 3'h3 == state ? _GEN_17 : _GEN_38; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
  wire [2:0] _GEN_46 = 3'h3 == state ? _GEN_18 : _GEN_40; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
  wire [31:0] _GEN_47 = 3'h3 == state ? write_data : _GEN_33; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 157:27]
  wire  _GEN_52 = 3'h3 == state ? write : _GEN_39; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 155:22]
  wire  _GEN_53 = 3'h3 == state ? BVALID : _GEN_41; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17 166:23]
  assign io_channels_write_address_channel_AWREADY = AWREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 163:45]
  assign io_channels_write_data_channel_WREADY = WREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 165:41]
  assign io_channels_write_response_channel_BVALID = BVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 167:45]
  assign io_channels_read_address_channel_ARREADY = ARREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 148:44]
  assign io_channels_read_data_channel_RVALID = RVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 150:40]
  assign io_channels_read_data_channel_RDATA = read_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 145:39]
  assign io_bundle_address = addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 139:21]
  assign io_bundle_read = read; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 143:18]
  assign io_bundle_write = write; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 156:19]
  assign io_bundle_write_data = write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 158:24]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 136:22]
      state <= 3'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 136:22]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (io_channels_read_address_channel_ARVALID) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 176:54]
        state <= 3'h1; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 178:17]
      end else if (io_channels_write_address_channel_AWVALID) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 180:61]
        state <= 3'h3; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 182:17]
      end
    end else if (3'h1 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (io_channels_read_address_channel_ARVALID & ARREADY) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 188:65]
        state <= 3'h2; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 193:17]
      end
    end else if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      state <= _GEN_14;
    end else begin
      state <= _GEN_46;
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 138:21]
      addr <= 8'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 138:21]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (3'h1 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (io_channels_read_address_channel_ARVALID & ARREADY) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 188:65]
          addr <= io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 190:17]
        end
      end else if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        addr <= _GEN_43;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 142:21]
      read <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 142:21]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      read <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 173:13]
    end else if (3'h1 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      read <= _GEN_7;
    end else if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      read <= _GEN_12;
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 144:26]
      read_data <= 32'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 144:26]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          read_data <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 147:24]
      ARREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 147:24]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      ARREADY <= _GEN_3;
    end else if (3'h1 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (io_channels_read_address_channel_ARVALID & ARREADY) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 188:65]
        ARREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 191:17]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 149:23]
      RVALID <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 149:23]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          RVALID <= _GEN_13;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 155:22]
      write <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 155:22]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      write <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 174:13]
    end else if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        write <= _GEN_52;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 157:27]
      write_data <= 32'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 157:27]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          write_data <= _GEN_47;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 162:24]
      AWREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 162:24]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(io_channels_read_address_channel_ARVALID)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 176:54]
        AWREADY <= _GEN_1;
      end
    end else if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        AWREADY <= _GEN_44;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 164:23]
      WREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 164:23]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          WREADY <= _GEN_45;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 166:23]
      BVALID <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 166:23]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
      if (!(3'h1 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
        if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 171:17]
          BVALID <= _GEN_53;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  addr = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  read = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  read_data = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  ARREADY = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  RVALID = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  write = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  write_data = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  AWREADY = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  WREADY = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  BVALID = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module VGA(
  input         clock,
  input         reset,
  input         io_channels_write_address_channel_AWVALID, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output        io_channels_write_address_channel_AWREADY, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  input  [7:0]  io_channels_write_address_channel_AWADDR, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  input         io_channels_write_data_channel_WVALID, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output        io_channels_write_data_channel_WREADY, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  input  [31:0] io_channels_write_data_channel_WDATA, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output        io_channels_write_response_channel_BVALID, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  input         io_channels_write_response_channel_BREADY, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  input         io_channels_read_address_channel_ARVALID, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output        io_channels_read_address_channel_ARREADY, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  input  [7:0]  io_channels_read_address_channel_ARADDR, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output        io_channels_read_data_channel_RVALID, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  input         io_channels_read_data_channel_RREADY, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output [31:0] io_channels_read_data_channel_RDATA, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  input         io_pixClock, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output        io_hsync, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output        io_vsync, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output [5:0]  io_rrggbb, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output        io_activevideo, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output [9:0]  io_x_pos, // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
  output [9:0]  io_y_pos // @[4-soc/src/main/scala/peripheral/VGA.scala 35:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
`endif // RANDOMIZE_REG_INIT
  wire  framebuffer_clka; // @[4-soc/src/main/scala/peripheral/VGA.scala 99:27]
  wire  framebuffer_wea; // @[4-soc/src/main/scala/peripheral/VGA.scala 99:27]
  wire [12:0] framebuffer_addra; // @[4-soc/src/main/scala/peripheral/VGA.scala 99:27]
  wire [31:0] framebuffer_dina; // @[4-soc/src/main/scala/peripheral/VGA.scala 99:27]
  wire  framebuffer_clkb; // @[4-soc/src/main/scala/peripheral/VGA.scala 99:27]
  wire [12:0] framebuffer_addrb; // @[4-soc/src/main/scala/peripheral/VGA.scala 99:27]
  wire [31:0] framebuffer_doutb; // @[4-soc/src/main/scala/peripheral/VGA.scala 99:27]
  wire  slave_clock; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_reset; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire [7:0] slave_io_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire [31:0] slave_io_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire [7:0] slave_io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire [31:0] slave_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire [7:0] slave_io_bundle_address; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_bundle_read; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire [31:0] slave_io_bundle_read_data; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_bundle_read_valid; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire  slave_io_bundle_write; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  wire [31:0] slave_io_bundle_write_data; // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
  reg [31:0] ctrlReg; // @[4-soc/src/main/scala/peripheral/VGA.scala 109:30]
  reg [31:0] intrStatusReg; // @[4-soc/src/main/scala/peripheral/VGA.scala 110:30]
  reg [31:0] uploadAddrReg; // @[4-soc/src/main/scala/peripheral/VGA.scala 111:30]
  reg [5:0] paletteReg_0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_2; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_3; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_4; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_5; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_6; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_7; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_8; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_9; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_10; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_11; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_12; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_13; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_14; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  reg [5:0] paletteReg_15; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
  wire [3:0] ctrl_frame_sel = ctrlReg[7:4]; // @[4-soc/src/main/scala/peripheral/VGA.scala 118:31]
  wire  ctrl_vblank_ie = ctrlReg[8]; // @[4-soc/src/main/scala/peripheral/VGA.scala 119:31]
  wire [15:0] upload_pix_addr = uploadAddrReg[15:0]; // @[4-soc/src/main/scala/peripheral/VGA.scala 128:41]
  wire [3:0] upload_frame_raw = uploadAddrReg[19:16]; // @[4-soc/src/main/scala/peripheral/VGA.scala 129:41]
  wire [3:0] upload_frame = upload_frame_raw >= 4'hc ? 4'hb : upload_frame_raw; // @[4-soc/src/main/scala/peripheral/VGA.scala 130:31]
  reg  vblank_sync1; // @[4-soc/src/main/scala/peripheral/VGA.scala 133:36]
  reg  vblank_synced; // @[4-soc/src/main/scala/peripheral/VGA.scala 134:36]
  reg [3:0] curr_frame_sync1; // @[4-soc/src/main/scala/peripheral/VGA.scala 135:36]
  reg [3:0] curr_frame_synced; // @[4-soc/src/main/scala/peripheral/VGA.scala 136:36]
  reg  timing_err_sync1; // @[4-soc/src/main/scala/peripheral/VGA.scala 141:37]
  reg  timing_err_sync2; // @[4-soc/src/main/scala/peripheral/VGA.scala 142:37]
  reg  timing_err_sync3; // @[4-soc/src/main/scala/peripheral/VGA.scala 143:37]
  wire  timing_err_edge = timing_err_sync2 != timing_err_sync3; // @[4-soc/src/main/scala/peripheral/VGA.scala 144:47]
  reg [15:0] timing_error_count; // @[4-soc/src/main/scala/peripheral/VGA.scala 145:37]
  wire [15:0] _timing_error_count_T_1 = timing_error_count + 16'h1; // @[4-soc/src/main/scala/peripheral/VGA.scala 147:48]
  reg  vblank_prev; // @[4-soc/src/main/scala/peripheral/VGA.scala 157:37]
  wire  vblank_rising_edge = vblank_synced & ~vblank_prev; // @[4-soc/src/main/scala/peripheral/VGA.scala 158:44]
  wire [31:0] _GEN_1 = vblank_rising_edge & ctrl_vblank_ie ? 32'h1 : intrStatusReg; // @[4-soc/src/main/scala/peripheral/VGA.scala 160:48 161:21 110:30]
  wire [7:0] addr = slave_io_bundle_address; // @[4-soc/src/main/scala/peripheral/VGA.scala 167:52]
  wire  addr_id = addr == 8'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 168:33]
  wire  addr_status = addr == 8'h4; // @[4-soc/src/main/scala/peripheral/VGA.scala 169:33]
  wire  addr_intr_status = addr == 8'h8; // @[4-soc/src/main/scala/peripheral/VGA.scala 170:33]
  wire  addr_upload_addr = addr == 8'h10; // @[4-soc/src/main/scala/peripheral/VGA.scala 171:33]
  wire  addr_stream_data = addr == 8'h14; // @[4-soc/src/main/scala/peripheral/VGA.scala 172:33]
  wire  addr_ctrl = addr == 8'h20; // @[4-soc/src/main/scala/peripheral/VGA.scala 173:33]
  wire  addr_palette = addr >= 8'h24 & addr < 8'h64; // @[4-soc/src/main/scala/peripheral/VGA.scala 174:57]
  wire [7:0] _palette_idx_T_1 = addr - 8'h24; // @[4-soc/src/main/scala/peripheral/VGA.scala 175:34]
  wire [5:0] palette_idx = _palette_idx_T_1[7:2]; // @[4-soc/src/main/scala/peripheral/VGA.scala 175:56]
  wire [31:0] _read_data_prepared_T = {timing_error_count,8'h0,curr_frame_synced,1'h0,1'h0,vblank_synced,vblank_synced}; // @[4-soc/src/main/scala/peripheral/VGA.scala 206:32]
  wire [5:0] _GEN_3 = 4'h1 == palette_idx[3:0] ? paletteReg_1 : paletteReg_0; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_4 = 4'h2 == palette_idx[3:0] ? paletteReg_2 : _GEN_3; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_5 = 4'h3 == palette_idx[3:0] ? paletteReg_3 : _GEN_4; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_6 = 4'h4 == palette_idx[3:0] ? paletteReg_4 : _GEN_5; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_7 = 4'h5 == palette_idx[3:0] ? paletteReg_5 : _GEN_6; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_8 = 4'h6 == palette_idx[3:0] ? paletteReg_6 : _GEN_7; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_9 = 4'h7 == palette_idx[3:0] ? paletteReg_7 : _GEN_8; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_10 = 4'h8 == palette_idx[3:0] ? paletteReg_8 : _GEN_9; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_11 = 4'h9 == palette_idx[3:0] ? paletteReg_9 : _GEN_10; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_12 = 4'ha == palette_idx[3:0] ? paletteReg_10 : _GEN_11; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_13 = 4'hb == palette_idx[3:0] ? paletteReg_11 : _GEN_12; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_14 = 4'hc == palette_idx[3:0] ? paletteReg_12 : _GEN_13; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_15 = 4'hd == palette_idx[3:0] ? paletteReg_13 : _GEN_14; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_16 = 4'he == palette_idx[3:0] ? paletteReg_14 : _GEN_15; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [5:0] _GEN_17 = 4'hf == palette_idx[3:0] ? paletteReg_15 : _GEN_16; // @[4-soc/src/main/scala/peripheral/VGA.scala 220:{26,26}]
  wire [31:0] _GEN_18 = addr_palette ? {{26'd0}, _GEN_17} : 32'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 219:30 220:26 191:41]
  wire [31:0] _GEN_19 = addr_upload_addr ? uploadAddrReg : _GEN_18; // @[4-soc/src/main/scala/peripheral/VGA.scala 217:34 218:26]
  wire [31:0] _GEN_20 = addr_intr_status ? intrStatusReg : _GEN_19; // @[4-soc/src/main/scala/peripheral/VGA.scala 215:34 216:26]
  wire [31:0] _GEN_21 = addr_status ? _read_data_prepared_T : _GEN_20; // @[4-soc/src/main/scala/peripheral/VGA.scala 197:29 206:26]
  wire [31:0] _GEN_22 = addr_ctrl ? ctrlReg : _GEN_21; // @[4-soc/src/main/scala/peripheral/VGA.scala 195:27 196:26]
  wire [3:0] requested_frame = slave_io_bundle_write_data[7:4]; // @[4-soc/src/main/scala/peripheral/VGA.scala 238:57]
  wire  display_enable = slave_io_bundle_write_data[0]; // @[4-soc/src/main/scala/peripheral/VGA.scala 239:57]
  wire [31:0] _ctrlReg_T_3 = {ctrlReg[31:8],ctrl_frame_sel,3'h0,display_enable}; // @[4-soc/src/main/scala/peripheral/VGA.scala 243:25]
  wire [31:0] _intrStatusReg_T = ~slave_io_bundle_write_data; // @[4-soc/src/main/scala/peripheral/VGA.scala 246:42]
  wire [31:0] _intrStatusReg_T_1 = intrStatusReg & _intrStatusReg_T; // @[4-soc/src/main/scala/peripheral/VGA.scala 246:40]
  wire [12:0] word_offset = upload_pix_addr[15:3]; // @[4-soc/src/main/scala/peripheral/VGA.scala 251:51]
  wire [13:0] frame_base = upload_frame * 10'h200; // @[4-soc/src/main/scala/peripheral/VGA.scala 252:46]
  wire [13:0] _GEN_185 = {{1'd0}, word_offset}; // @[4-soc/src/main/scala/peripheral/VGA.scala 253:44]
  wire [13:0] fb_addr = frame_base + _GEN_185; // @[4-soc/src/main/scala/peripheral/VGA.scala 253:44]
  wire [15:0] next_addr = upload_pix_addr + 16'h8; // @[4-soc/src/main/scala/peripheral/VGA.scala 259:44]
  wire [15:0] wrapped_addr = next_addr >= 16'h1000 ? 16'h0 : next_addr; // @[4-soc/src/main/scala/peripheral/VGA.scala 260:31]
  wire [19:0] _uploadAddrReg_T = {upload_frame,wrapped_addr}; // @[4-soc/src/main/scala/peripheral/VGA.scala 261:29]
  wire [5:0] _GEN_25 = 4'h0 == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_26 = 4'h1 == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_27 = 4'h2 == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_2; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_28 = 4'h3 == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_3; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_29 = 4'h4 == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_4; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_30 = 4'h5 == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_5; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_31 = 4'h6 == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_6; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_32 = 4'h7 == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_7; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_33 = 4'h8 == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_8; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_34 = 4'h9 == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_9; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_35 = 4'ha == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_10; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_36 = 4'hb == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_11; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_37 = 4'hc == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_12; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_38 = 4'hd == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_13; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_39 = 4'he == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_14; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_40 = 4'hf == palette_idx[3:0] ? slave_io_bundle_write_data[5:0] : paletteReg_15; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 263:{33,33}]
  wire [5:0] _GEN_41 = addr_palette ? _GEN_25 : paletteReg_0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_42 = addr_palette ? _GEN_26 : paletteReg_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_43 = addr_palette ? _GEN_27 : paletteReg_2; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_44 = addr_palette ? _GEN_28 : paletteReg_3; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_45 = addr_palette ? _GEN_29 : paletteReg_4; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_46 = addr_palette ? _GEN_30 : paletteReg_5; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_47 = addr_palette ? _GEN_31 : paletteReg_6; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_48 = addr_palette ? _GEN_32 : paletteReg_7; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_49 = addr_palette ? _GEN_33 : paletteReg_8; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_50 = addr_palette ? _GEN_34 : paletteReg_9; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_51 = addr_palette ? _GEN_35 : paletteReg_10; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_52 = addr_palette ? _GEN_36 : paletteReg_11; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_53 = addr_palette ? _GEN_37 : paletteReg_12; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_54 = addr_palette ? _GEN_38 : paletteReg_13; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_55 = addr_palette ? _GEN_39 : paletteReg_14; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [5:0] _GEN_56 = addr_palette ? _GEN_40 : paletteReg_15; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 262:32]
  wire [13:0] _GEN_58 = addr_stream_data ? fb_addr : 14'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 249:36 256:23 232:36]
  wire [31:0] _GEN_59 = addr_stream_data ? slave_io_bundle_write_data : 32'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 249:36 257:23 233:36]
  wire [31:0] _GEN_60 = addr_stream_data ? {{12'd0}, _uploadAddrReg_T} : uploadAddrReg; // @[4-soc/src/main/scala/peripheral/VGA.scala 249:36 261:23 111:30]
  wire [5:0] _GEN_61 = addr_stream_data ? paletteReg_0 : _GEN_41; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_62 = addr_stream_data ? paletteReg_1 : _GEN_42; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_63 = addr_stream_data ? paletteReg_2 : _GEN_43; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_64 = addr_stream_data ? paletteReg_3 : _GEN_44; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_65 = addr_stream_data ? paletteReg_4 : _GEN_45; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_66 = addr_stream_data ? paletteReg_5 : _GEN_46; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_67 = addr_stream_data ? paletteReg_6 : _GEN_47; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_68 = addr_stream_data ? paletteReg_7 : _GEN_48; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_69 = addr_stream_data ? paletteReg_8 : _GEN_49; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_70 = addr_stream_data ? paletteReg_9 : _GEN_50; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_71 = addr_stream_data ? paletteReg_10 : _GEN_51; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_72 = addr_stream_data ? paletteReg_11 : _GEN_52; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_73 = addr_stream_data ? paletteReg_12 : _GEN_53; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_74 = addr_stream_data ? paletteReg_13 : _GEN_54; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_75 = addr_stream_data ? paletteReg_14 : _GEN_55; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [5:0] _GEN_76 = addr_stream_data ? paletteReg_15 : _GEN_56; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 249:36]
  wire [31:0] _GEN_77 = addr_upload_addr ? slave_io_bundle_write_data : _GEN_60; // @[4-soc/src/main/scala/peripheral/VGA.scala 247:36 248:23]
  wire  _GEN_78 = addr_upload_addr ? 1'h0 : addr_stream_data; // @[4-soc/src/main/scala/peripheral/VGA.scala 231:36 247:36]
  wire [13:0] _GEN_79 = addr_upload_addr ? 14'h0 : _GEN_58; // @[4-soc/src/main/scala/peripheral/VGA.scala 232:36 247:36]
  wire [31:0] _GEN_80 = addr_upload_addr ? 32'h0 : _GEN_59; // @[4-soc/src/main/scala/peripheral/VGA.scala 233:36 247:36]
  wire [5:0] _GEN_81 = addr_upload_addr ? paletteReg_0 : _GEN_61; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_82 = addr_upload_addr ? paletteReg_1 : _GEN_62; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_83 = addr_upload_addr ? paletteReg_2 : _GEN_63; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_84 = addr_upload_addr ? paletteReg_3 : _GEN_64; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_85 = addr_upload_addr ? paletteReg_4 : _GEN_65; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_86 = addr_upload_addr ? paletteReg_5 : _GEN_66; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_87 = addr_upload_addr ? paletteReg_6 : _GEN_67; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_88 = addr_upload_addr ? paletteReg_7 : _GEN_68; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_89 = addr_upload_addr ? paletteReg_8 : _GEN_69; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_90 = addr_upload_addr ? paletteReg_9 : _GEN_70; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_91 = addr_upload_addr ? paletteReg_10 : _GEN_71; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_92 = addr_upload_addr ? paletteReg_11 : _GEN_72; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_93 = addr_upload_addr ? paletteReg_12 : _GEN_73; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_94 = addr_upload_addr ? paletteReg_13 : _GEN_74; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_95 = addr_upload_addr ? paletteReg_14 : _GEN_75; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire [5:0] _GEN_96 = addr_upload_addr ? paletteReg_15 : _GEN_76; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30 247:36]
  wire  _GEN_99 = addr_intr_status ? 1'h0 : _GEN_78; // @[4-soc/src/main/scala/peripheral/VGA.scala 231:36 245:36]
  wire [13:0] _GEN_100 = addr_intr_status ? 14'h0 : _GEN_79; // @[4-soc/src/main/scala/peripheral/VGA.scala 232:36 245:36]
  wire [31:0] _GEN_101 = addr_intr_status ? 32'h0 : _GEN_80; // @[4-soc/src/main/scala/peripheral/VGA.scala 233:36 245:36]
  wire  _GEN_121 = addr_ctrl ? 1'h0 : _GEN_99; // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23 231:36]
  wire [13:0] _GEN_122 = addr_ctrl ? 14'h0 : _GEN_100; // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23 232:36]
  wire [31:0] _GEN_123 = addr_ctrl ? 32'h0 : _GEN_101; // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23 233:36]
  wire [13:0] _GEN_144 = slave_io_bundle_write ? _GEN_122 : 14'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33 232:36]
  reg [9:0] h_count; // @[4-soc/src/main/scala/peripheral/VGA.scala 274:26]
  reg [9:0] v_count; // @[4-soc/src/main/scala/peripheral/VGA.scala 275:26]
  wire  _T_5 = h_count == 10'h33f; // @[4-soc/src/main/scala/peripheral/VGA.scala 277:18]
  wire  _T_6 = v_count == 10'h207; // @[4-soc/src/main/scala/peripheral/VGA.scala 279:20]
  wire [9:0] _v_count_T_1 = v_count + 10'h1; // @[4-soc/src/main/scala/peripheral/VGA.scala 282:28]
  wire [9:0] _h_count_T_1 = h_count + 10'h1; // @[4-soc/src/main/scala/peripheral/VGA.scala 285:26]
  reg [1:0] frame_count; // @[4-soc/src/main/scala/peripheral/VGA.scala 290:30]
  wire  first_frame = frame_count == 2'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 291:35]
  wire [1:0] _frame_count_T_1 = frame_count + 2'h1; // @[4-soc/src/main/scala/peripheral/VGA.scala 293:34]
  wire  h_sync_pulse = h_count >= 10'h298 & h_count < 10'h2c0; // @[4-soc/src/main/scala/peripheral/VGA.scala 296:57]
  wire  v_sync_pulse = v_count >= 10'h1e9 & v_count < 10'h1ec; // @[4-soc/src/main/scala/peripheral/VGA.scala 297:57]
  reg  hsync_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 298:31]
  reg  vsync_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 299:31]
  reg  io_hsync_REG; // @[4-soc/src/main/scala/peripheral/VGA.scala 300:24]
  reg  io_vsync_REG; // @[4-soc/src/main/scala/peripheral/VGA.scala 301:24]
  reg [9:0] x_px; // @[4-soc/src/main/scala/peripheral/VGA.scala 306:23]
  reg [9:0] y_px; // @[4-soc/src/main/scala/peripheral/VGA.scala 307:23]
  wire  _in_display_x_T = x_px >= 10'h80; // @[4-soc/src/main/scala/peripheral/VGA.scala 309:30]
  wire  in_display_x = x_px >= 10'h80 & x_px < 10'h200; // @[4-soc/src/main/scala/peripheral/VGA.scala 309:48]
  wire  _in_display_y_T = y_px >= 10'h30; // @[4-soc/src/main/scala/peripheral/VGA.scala 310:30]
  wire  in_display_y = y_px >= 10'h30 & y_px < 10'h1b0; // @[4-soc/src/main/scala/peripheral/VGA.scala 310:47]
  wire [9:0] _rel_x_T_2 = x_px - 10'h80; // @[4-soc/src/main/scala/peripheral/VGA.scala 313:49]
  wire [9:0] rel_x = _in_display_x_T ? _rel_x_T_2 : 10'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 313:20]
  wire [9:0] _rel_y_T_2 = y_px - 10'h30; // @[4-soc/src/main/scala/peripheral/VGA.scala 314:48]
  wire [9:0] rel_y = _in_display_y_T ? _rel_y_T_2 : 10'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 314:20]
  wire [23:0] frame_x_mult = rel_x * 14'h2aab; // @[4-soc/src/main/scala/peripheral/VGA.scala 317:30]
  wire [7:0] frame_x_div = frame_x_mult[23:16]; // @[4-soc/src/main/scala/peripheral/VGA.scala 318:36]
  wire [23:0] frame_y_mult = rel_y * 14'h2aab; // @[4-soc/src/main/scala/peripheral/VGA.scala 319:30]
  wire [7:0] frame_y_div = frame_y_mult[23:16]; // @[4-soc/src/main/scala/peripheral/VGA.scala 320:36]
  wire [5:0] frame_x = frame_x_div >= 8'h40 ? 6'h3f : frame_x_div[5:0]; // @[4-soc/src/main/scala/peripheral/VGA.scala 321:27]
  wire [5:0] frame_y = frame_y_div >= 8'h40 ? 6'h3f : frame_y_div[5:0]; // @[4-soc/src/main/scala/peripheral/VGA.scala 322:27]
  reg [3:0] curr_frame_sync1_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 325:35]
  reg [3:0] curr_frame; // @[4-soc/src/main/scala/peripheral/VGA.scala 326:35]
  reg  display_enabled_sync1; // @[4-soc/src/main/scala/peripheral/VGA.scala 328:40]
  reg  display_enabled; // @[4-soc/src/main/scala/peripheral/VGA.scala 329:40]
  reg  blanking_sync1; // @[4-soc/src/main/scala/peripheral/VGA.scala 331:33]
  reg  blanking; // @[4-soc/src/main/scala/peripheral/VGA.scala 332:33]
  reg [5:0] palette_sync1_0; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_2; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_3; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_4; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_5; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_6; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_7; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_8; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_9; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_10; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_11; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_12; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_13; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_14; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync1_15; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
  reg [5:0] palette_sync_0; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_2; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_3; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_4; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_5; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_6; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_7; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_8; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_9; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_10; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_11; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_12; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_13; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_14; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg [5:0] palette_sync_15; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
  reg  in_display_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 340:37]
  reg  h_active_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 347:30]
  reg  v_active_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 348:30]
  reg  h_active_d2; // @[4-soc/src/main/scala/peripheral/VGA.scala 349:30]
  reg  v_active_d2; // @[4-soc/src/main/scala/peripheral/VGA.scala 350:30]
  wire [12:0] _pixel_idx_T = frame_y * 7'h40; // @[4-soc/src/main/scala/peripheral/VGA.scala 352:33]
  wire [12:0] _GEN_186 = {{7'd0}, frame_x}; // @[4-soc/src/main/scala/peripheral/VGA.scala 352:49]
  wire [12:0] pixel_idx = _pixel_idx_T + _GEN_186; // @[4-soc/src/main/scala/peripheral/VGA.scala 352:49]
  wire [9:0] word_offset_1 = pixel_idx[12:3]; // @[4-soc/src/main/scala/peripheral/VGA.scala 353:35]
  wire [13:0] frame_base_1 = curr_frame * 10'h200; // @[4-soc/src/main/scala/peripheral/VGA.scala 355:36]
  wire [13:0] _GEN_187 = {{4'd0}, word_offset_1}; // @[4-soc/src/main/scala/peripheral/VGA.scala 356:36]
  wire [13:0] fb_read_addr = frame_base_1 + _GEN_187; // @[4-soc/src/main/scala/peripheral/VGA.scala 356:36]
  reg [2:0] pixel_in_word_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 361:35]
  wire [3:0] _pixel_4bit_T_9 = 3'h0 == pixel_in_word_d1 ? framebuffer_doutb[3:0] : 4'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 365:51]
  wire [3:0] _pixel_4bit_T_11 = 3'h1 == pixel_in_word_d1 ? framebuffer_doutb[7:4] : _pixel_4bit_T_9; // @[4-soc/src/main/scala/peripheral/VGA.scala 365:51]
  wire [3:0] _pixel_4bit_T_13 = 3'h2 == pixel_in_word_d1 ? framebuffer_doutb[11:8] : _pixel_4bit_T_11; // @[4-soc/src/main/scala/peripheral/VGA.scala 365:51]
  wire [3:0] _pixel_4bit_T_15 = 3'h3 == pixel_in_word_d1 ? framebuffer_doutb[15:12] : _pixel_4bit_T_13; // @[4-soc/src/main/scala/peripheral/VGA.scala 365:51]
  wire [3:0] _pixel_4bit_T_17 = 3'h4 == pixel_in_word_d1 ? framebuffer_doutb[19:16] : _pixel_4bit_T_15; // @[4-soc/src/main/scala/peripheral/VGA.scala 365:51]
  wire [3:0] _pixel_4bit_T_19 = 3'h5 == pixel_in_word_d1 ? framebuffer_doutb[23:20] : _pixel_4bit_T_17; // @[4-soc/src/main/scala/peripheral/VGA.scala 365:51]
  wire [3:0] _pixel_4bit_T_21 = 3'h6 == pixel_in_word_d1 ? framebuffer_doutb[27:24] : _pixel_4bit_T_19; // @[4-soc/src/main/scala/peripheral/VGA.scala 365:51]
  wire [3:0] pixel_4bit = 3'h7 == pixel_in_word_d1 ? framebuffer_doutb[31:28] : _pixel_4bit_T_21; // @[4-soc/src/main/scala/peripheral/VGA.scala 365:51]
  wire [5:0] _GEN_167 = 4'h1 == pixel_4bit ? palette_sync_1 : palette_sync_0; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_168 = 4'h2 == pixel_4bit ? palette_sync_2 : _GEN_167; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_169 = 4'h3 == pixel_4bit ? palette_sync_3 : _GEN_168; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_170 = 4'h4 == pixel_4bit ? palette_sync_4 : _GEN_169; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_171 = 4'h5 == pixel_4bit ? palette_sync_5 : _GEN_170; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_172 = 4'h6 == pixel_4bit ? palette_sync_6 : _GEN_171; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_173 = 4'h7 == pixel_4bit ? palette_sync_7 : _GEN_172; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_174 = 4'h8 == pixel_4bit ? palette_sync_8 : _GEN_173; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_175 = 4'h9 == pixel_4bit ? palette_sync_9 : _GEN_174; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_176 = 4'ha == pixel_4bit ? palette_sync_10 : _GEN_175; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_177 = 4'hb == pixel_4bit ? palette_sync_11 : _GEN_176; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_178 = 4'hc == pixel_4bit ? palette_sync_12 : _GEN_177; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_179 = 4'hd == pixel_4bit ? palette_sync_13 : _GEN_178; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_180 = 4'he == pixel_4bit ? palette_sync_14 : _GEN_179; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_181 = 4'hf == pixel_4bit ? palette_sync_15 : _GEN_180; // @[4-soc/src/main/scala/peripheral/VGA.scala 384:{20,20}]
  wire [5:0] _GEN_182 = display_enabled & in_display_d1 ? _GEN_181 : 6'h1; // @[4-soc/src/main/scala/peripheral/VGA.scala 383:50 384:20 386:20]
  wire [5:0] output_color = blanking ? 6'h0 : _GEN_182; // @[4-soc/src/main/scala/peripheral/VGA.scala 381:20 382:20]
  reg [9:0] x_px_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 393:26]
  reg [9:0] y_px_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 394:26]
  reg  timing_err_toggle; // @[4-soc/src/main/scala/peripheral/VGA.scala 407:36]
  wire  h_overflow = h_count >= 10'h340; // @[4-soc/src/main/scala/peripheral/VGA.scala 408:37]
  wire  v_overflow = v_count >= 10'h208; // @[4-soc/src/main/scala/peripheral/VGA.scala 409:37]
  wire  timing_anomaly = h_overflow | v_overflow; // @[4-soc/src/main/scala/peripheral/VGA.scala 410:40]
  TrueDualPortRAM32 #(.ADDR_WIDTH(13), .DEPTH(6144)) framebuffer ( // @[4-soc/src/main/scala/peripheral/VGA.scala 99:27]
    .clka(framebuffer_clka),
    .wea(framebuffer_wea),
    .addra(framebuffer_addra),
    .dina(framebuffer_dina),
    .clkb(framebuffer_clkb),
    .addrb(framebuffer_addrb),
    .doutb(framebuffer_doutb)
  );
  AXI4LiteSlave_1 slave ( // @[4-soc/src/main/scala/peripheral/VGA.scala 102:21]
    .clock(slave_clock),
    .reset(slave_reset),
    .io_channels_write_address_channel_AWVALID(slave_io_channels_write_address_channel_AWVALID),
    .io_channels_write_address_channel_AWREADY(slave_io_channels_write_address_channel_AWREADY),
    .io_channels_write_address_channel_AWADDR(slave_io_channels_write_address_channel_AWADDR),
    .io_channels_write_data_channel_WVALID(slave_io_channels_write_data_channel_WVALID),
    .io_channels_write_data_channel_WREADY(slave_io_channels_write_data_channel_WREADY),
    .io_channels_write_data_channel_WDATA(slave_io_channels_write_data_channel_WDATA),
    .io_channels_write_response_channel_BVALID(slave_io_channels_write_response_channel_BVALID),
    .io_channels_write_response_channel_BREADY(slave_io_channels_write_response_channel_BREADY),
    .io_channels_read_address_channel_ARVALID(slave_io_channels_read_address_channel_ARVALID),
    .io_channels_read_address_channel_ARREADY(slave_io_channels_read_address_channel_ARREADY),
    .io_channels_read_address_channel_ARADDR(slave_io_channels_read_address_channel_ARADDR),
    .io_channels_read_data_channel_RVALID(slave_io_channels_read_data_channel_RVALID),
    .io_channels_read_data_channel_RREADY(slave_io_channels_read_data_channel_RREADY),
    .io_channels_read_data_channel_RDATA(slave_io_channels_read_data_channel_RDATA),
    .io_bundle_address(slave_io_bundle_address),
    .io_bundle_read(slave_io_bundle_read),
    .io_bundle_read_data(slave_io_bundle_read_data),
    .io_bundle_read_valid(slave_io_bundle_read_valid),
    .io_bundle_write(slave_io_bundle_write),
    .io_bundle_write_data(slave_io_bundle_write_data)
  );
  assign io_channels_write_address_channel_AWREADY = slave_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign io_channels_write_data_channel_WREADY = slave_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign io_channels_write_response_channel_BVALID = slave_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign io_channels_read_address_channel_ARREADY = slave_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign io_channels_read_data_channel_RVALID = slave_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign io_channels_read_data_channel_RDATA = slave_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign io_hsync = io_hsync_REG; // @[4-soc/src/main/scala/peripheral/VGA.scala 300:14]
  assign io_vsync = io_vsync_REG; // @[4-soc/src/main/scala/peripheral/VGA.scala 301:14]
  assign io_rrggbb = h_active_d2 & v_active_d2 & ~first_frame ? output_color : 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 390:26]
  assign io_activevideo = h_active_d2 & v_active_d2; // @[4-soc/src/main/scala/peripheral/VGA.scala 391:35]
  assign io_x_pos = x_px_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 395:14]
  assign io_y_pos = y_px_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 396:14]
  assign framebuffer_clka = clock; // @[4-soc/src/main/scala/peripheral/VGA.scala 229:25]
  assign framebuffer_wea = slave_io_bundle_write & _GEN_121; // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33 231:36]
  assign framebuffer_addra = _GEN_144[12:0]; // @[4-soc/src/main/scala/peripheral/VGA.scala 232:36]
  assign framebuffer_dina = slave_io_bundle_write ? _GEN_123 : 32'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33 233:36]
  assign framebuffer_clkb = io_pixClock; // @[4-soc/src/main/scala/peripheral/VGA.scala 358:26]
  assign framebuffer_addrb = fb_read_addr[12:0]; // @[4-soc/src/main/scala/peripheral/VGA.scala 359:26]
  assign slave_clock = clock;
  assign slave_reset = reset;
  assign slave_io_channels_write_address_channel_AWVALID = io_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign slave_io_channels_write_address_channel_AWADDR = io_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign slave_io_channels_write_data_channel_WVALID = io_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign slave_io_channels_write_data_channel_WDATA = io_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign slave_io_channels_write_response_channel_BREADY = io_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign slave_io_channels_read_address_channel_ARVALID = io_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign slave_io_channels_read_address_channel_ARADDR = io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign slave_io_channels_read_data_channel_RREADY = io_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/peripheral/VGA.scala 103:21]
  assign slave_io_bundle_read_data = addr_id ? 32'h56474131 : _GEN_22; // @[4-soc/src/main/scala/peripheral/VGA.scala 193:19 194:26]
  assign slave_io_bundle_read_valid = slave_io_bundle_read; // @[4-soc/src/main/scala/peripheral/VGA.scala 225:32]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 109:30]
      ctrlReg <= 32'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 109:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (addr_ctrl) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (requested_frame < 4'hc) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 240:38]
          ctrlReg <= slave_io_bundle_write_data; // @[4-soc/src/main/scala/peripheral/VGA.scala 241:19]
        end else begin
          ctrlReg <= _ctrlReg_T_3; // @[4-soc/src/main/scala/peripheral/VGA.scala 243:19]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 110:30]
      intrStatusReg <= 32'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 110:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (addr_ctrl) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        intrStatusReg <= _GEN_1;
      end else if (addr_intr_status) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
        intrStatusReg <= _intrStatusReg_T_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 246:23]
      end else begin
        intrStatusReg <= _GEN_1;
      end
    end else begin
      intrStatusReg <= _GEN_1;
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 111:30]
      uploadAddrReg <= 32'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 111:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          uploadAddrReg <= _GEN_77;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_0 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_0 <= _GEN_81;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_1 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_1 <= _GEN_82;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_2 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_2 <= _GEN_83;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_3 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_3 <= _GEN_84;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_4 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_4 <= _GEN_85;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_5 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_5 <= _GEN_86;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_6 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_6 <= _GEN_87;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_7 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_7 <= _GEN_88;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_8 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_8 <= _GEN_89;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_9 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_9 <= _GEN_90;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_10 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_10 <= _GEN_91;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_11 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_11 <= _GEN_92;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_12 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_12 <= _GEN_93;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_13 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_13 <= _GEN_94;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_14 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_14 <= _GEN_95;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
      paletteReg_15 <= 6'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 112:30]
    end else if (slave_io_bundle_write) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 236:33]
      if (!(addr_ctrl)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 237:23]
        if (!(addr_intr_status)) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 245:36]
          paletteReg_15 <= _GEN_96;
        end
      end
    end
    vblank_sync1 <= v_count >= 10'h1e0; // @[4-soc/src/main/scala/peripheral/VGA.scala 398:29]
    vblank_synced <= vblank_sync1; // @[4-soc/src/main/scala/peripheral/VGA.scala 134:36]
    curr_frame_sync1 <= curr_frame; // @[4-soc/src/main/scala/peripheral/VGA.scala 123:34 417:26]
    curr_frame_synced <= curr_frame_sync1; // @[4-soc/src/main/scala/peripheral/VGA.scala 136:36]
    timing_err_sync1 <= timing_err_toggle; // @[4-soc/src/main/scala/peripheral/VGA.scala 124:34 418:26]
    timing_err_sync2 <= timing_err_sync1; // @[4-soc/src/main/scala/peripheral/VGA.scala 142:37]
    timing_err_sync3 <= timing_err_sync2; // @[4-soc/src/main/scala/peripheral/VGA.scala 143:37]
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 145:37]
      timing_error_count <= 16'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 145:37]
    end else if (timing_err_edge & timing_error_count < 16'hffff) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 146:61]
      timing_error_count <= _timing_error_count_T_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 147:26]
    end
    vblank_prev <= vblank_synced; // @[4-soc/src/main/scala/peripheral/VGA.scala 157:37]
  end
  always @(posedge io_pixClock) begin
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 274:26]
      h_count <= 10'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 274:26]
    end else if (h_count == 10'h33f) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 277:39]
      h_count <= 10'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 278:15]
    end else begin
      h_count <= _h_count_T_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 285:15]
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 275:26]
      v_count <= 10'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 275:26]
    end else if (h_count == 10'h33f) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 277:39]
      if (v_count == 10'h207) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 279:41]
        v_count <= 10'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 280:17]
      end else begin
        v_count <= _v_count_T_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 282:17]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 290:30]
      frame_count <= 2'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 290:30]
    end else if (_T_5 & _T_6 & frame_count < 2'h2) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 292:91]
      frame_count <= _frame_count_T_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 293:19]
    end
    hsync_d1 <= ~h_sync_pulse; // @[4-soc/src/main/scala/peripheral/VGA.scala 298:32]
    vsync_d1 <= ~v_sync_pulse; // @[4-soc/src/main/scala/peripheral/VGA.scala 299:32]
    io_hsync_REG <= hsync_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 300:24]
    io_vsync_REG <= vsync_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 301:24]
    x_px <= h_count; // @[4-soc/src/main/scala/peripheral/VGA.scala 306:23]
    y_px <= v_count; // @[4-soc/src/main/scala/peripheral/VGA.scala 307:23]
    curr_frame_sync1_1 <= ctrlReg[7:4]; // @[4-soc/src/main/scala/peripheral/VGA.scala 118:31]
    curr_frame <= curr_frame_sync1_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 326:35]
    display_enabled_sync1 <= ctrlReg[0]; // @[4-soc/src/main/scala/peripheral/VGA.scala 115:31]
    display_enabled <= display_enabled_sync1; // @[4-soc/src/main/scala/peripheral/VGA.scala 329:40]
    blanking_sync1 <= ctrlReg[1]; // @[4-soc/src/main/scala/peripheral/VGA.scala 116:31]
    blanking <= blanking_sync1; // @[4-soc/src/main/scala/peripheral/VGA.scala 332:33]
    palette_sync1_0 <= paletteReg_0; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_1 <= paletteReg_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_2 <= paletteReg_2; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_3 <= paletteReg_3; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_4 <= paletteReg_4; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_5 <= paletteReg_5; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_6 <= paletteReg_6; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_7 <= paletteReg_7; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_8 <= paletteReg_8; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_9 <= paletteReg_9; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_10 <= paletteReg_10; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_11 <= paletteReg_11; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_12 <= paletteReg_12; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_13 <= paletteReg_13; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_14 <= paletteReg_14; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync1_15 <= paletteReg_15; // @[4-soc/src/main/scala/peripheral/VGA.scala 334:32]
    palette_sync_0 <= palette_sync1_0; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_1 <= palette_sync1_1; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_2 <= palette_sync1_2; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_3 <= palette_sync1_3; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_4 <= palette_sync1_4; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_5 <= palette_sync1_5; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_6 <= palette_sync1_6; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_7 <= palette_sync1_7; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_8 <= palette_sync1_8; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_9 <= palette_sync1_9; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_10 <= palette_sync1_10; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_11 <= palette_sync1_11; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_12 <= palette_sync1_12; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_13 <= palette_sync1_13; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_14 <= palette_sync1_14; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    palette_sync_15 <= palette_sync1_15; // @[4-soc/src/main/scala/peripheral/VGA.scala 335:32]
    in_display_d1 <= in_display_x & in_display_y; // @[4-soc/src/main/scala/peripheral/VGA.scala 311:37]
    h_active_d1 <= h_count < 10'h280; // @[4-soc/src/main/scala/peripheral/VGA.scala 303:28]
    v_active_d1 <= v_count < 10'h1e0; // @[4-soc/src/main/scala/peripheral/VGA.scala 304:28]
    h_active_d2 <= h_active_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 349:30]
    v_active_d2 <= v_active_d1; // @[4-soc/src/main/scala/peripheral/VGA.scala 350:30]
    pixel_in_word_d1 <= pixel_idx[2:0]; // @[4-soc/src/main/scala/peripheral/VGA.scala 354:34]
    x_px_d1 <= x_px; // @[4-soc/src/main/scala/peripheral/VGA.scala 393:26]
    y_px_d1 <= y_px; // @[4-soc/src/main/scala/peripheral/VGA.scala 394:26]
    if (reset) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 407:36]
      timing_err_toggle <= 1'h0; // @[4-soc/src/main/scala/peripheral/VGA.scala 407:36]
    end else if (timing_anomaly) begin // @[4-soc/src/main/scala/peripheral/VGA.scala 412:26]
      timing_err_toggle <= ~timing_err_toggle; // @[4-soc/src/main/scala/peripheral/VGA.scala 413:25]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ctrlReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  intrStatusReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  uploadAddrReg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  paletteReg_0 = _RAND_3[5:0];
  _RAND_4 = {1{`RANDOM}};
  paletteReg_1 = _RAND_4[5:0];
  _RAND_5 = {1{`RANDOM}};
  paletteReg_2 = _RAND_5[5:0];
  _RAND_6 = {1{`RANDOM}};
  paletteReg_3 = _RAND_6[5:0];
  _RAND_7 = {1{`RANDOM}};
  paletteReg_4 = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  paletteReg_5 = _RAND_8[5:0];
  _RAND_9 = {1{`RANDOM}};
  paletteReg_6 = _RAND_9[5:0];
  _RAND_10 = {1{`RANDOM}};
  paletteReg_7 = _RAND_10[5:0];
  _RAND_11 = {1{`RANDOM}};
  paletteReg_8 = _RAND_11[5:0];
  _RAND_12 = {1{`RANDOM}};
  paletteReg_9 = _RAND_12[5:0];
  _RAND_13 = {1{`RANDOM}};
  paletteReg_10 = _RAND_13[5:0];
  _RAND_14 = {1{`RANDOM}};
  paletteReg_11 = _RAND_14[5:0];
  _RAND_15 = {1{`RANDOM}};
  paletteReg_12 = _RAND_15[5:0];
  _RAND_16 = {1{`RANDOM}};
  paletteReg_13 = _RAND_16[5:0];
  _RAND_17 = {1{`RANDOM}};
  paletteReg_14 = _RAND_17[5:0];
  _RAND_18 = {1{`RANDOM}};
  paletteReg_15 = _RAND_18[5:0];
  _RAND_19 = {1{`RANDOM}};
  vblank_sync1 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  vblank_synced = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  curr_frame_sync1 = _RAND_21[3:0];
  _RAND_22 = {1{`RANDOM}};
  curr_frame_synced = _RAND_22[3:0];
  _RAND_23 = {1{`RANDOM}};
  timing_err_sync1 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  timing_err_sync2 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  timing_err_sync3 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  timing_error_count = _RAND_26[15:0];
  _RAND_27 = {1{`RANDOM}};
  vblank_prev = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  h_count = _RAND_28[9:0];
  _RAND_29 = {1{`RANDOM}};
  v_count = _RAND_29[9:0];
  _RAND_30 = {1{`RANDOM}};
  frame_count = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  hsync_d1 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  vsync_d1 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  io_hsync_REG = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  io_vsync_REG = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  x_px = _RAND_35[9:0];
  _RAND_36 = {1{`RANDOM}};
  y_px = _RAND_36[9:0];
  _RAND_37 = {1{`RANDOM}};
  curr_frame_sync1_1 = _RAND_37[3:0];
  _RAND_38 = {1{`RANDOM}};
  curr_frame = _RAND_38[3:0];
  _RAND_39 = {1{`RANDOM}};
  display_enabled_sync1 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  display_enabled = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  blanking_sync1 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  blanking = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  palette_sync1_0 = _RAND_43[5:0];
  _RAND_44 = {1{`RANDOM}};
  palette_sync1_1 = _RAND_44[5:0];
  _RAND_45 = {1{`RANDOM}};
  palette_sync1_2 = _RAND_45[5:0];
  _RAND_46 = {1{`RANDOM}};
  palette_sync1_3 = _RAND_46[5:0];
  _RAND_47 = {1{`RANDOM}};
  palette_sync1_4 = _RAND_47[5:0];
  _RAND_48 = {1{`RANDOM}};
  palette_sync1_5 = _RAND_48[5:0];
  _RAND_49 = {1{`RANDOM}};
  palette_sync1_6 = _RAND_49[5:0];
  _RAND_50 = {1{`RANDOM}};
  palette_sync1_7 = _RAND_50[5:0];
  _RAND_51 = {1{`RANDOM}};
  palette_sync1_8 = _RAND_51[5:0];
  _RAND_52 = {1{`RANDOM}};
  palette_sync1_9 = _RAND_52[5:0];
  _RAND_53 = {1{`RANDOM}};
  palette_sync1_10 = _RAND_53[5:0];
  _RAND_54 = {1{`RANDOM}};
  palette_sync1_11 = _RAND_54[5:0];
  _RAND_55 = {1{`RANDOM}};
  palette_sync1_12 = _RAND_55[5:0];
  _RAND_56 = {1{`RANDOM}};
  palette_sync1_13 = _RAND_56[5:0];
  _RAND_57 = {1{`RANDOM}};
  palette_sync1_14 = _RAND_57[5:0];
  _RAND_58 = {1{`RANDOM}};
  palette_sync1_15 = _RAND_58[5:0];
  _RAND_59 = {1{`RANDOM}};
  palette_sync_0 = _RAND_59[5:0];
  _RAND_60 = {1{`RANDOM}};
  palette_sync_1 = _RAND_60[5:0];
  _RAND_61 = {1{`RANDOM}};
  palette_sync_2 = _RAND_61[5:0];
  _RAND_62 = {1{`RANDOM}};
  palette_sync_3 = _RAND_62[5:0];
  _RAND_63 = {1{`RANDOM}};
  palette_sync_4 = _RAND_63[5:0];
  _RAND_64 = {1{`RANDOM}};
  palette_sync_5 = _RAND_64[5:0];
  _RAND_65 = {1{`RANDOM}};
  palette_sync_6 = _RAND_65[5:0];
  _RAND_66 = {1{`RANDOM}};
  palette_sync_7 = _RAND_66[5:0];
  _RAND_67 = {1{`RANDOM}};
  palette_sync_8 = _RAND_67[5:0];
  _RAND_68 = {1{`RANDOM}};
  palette_sync_9 = _RAND_68[5:0];
  _RAND_69 = {1{`RANDOM}};
  palette_sync_10 = _RAND_69[5:0];
  _RAND_70 = {1{`RANDOM}};
  palette_sync_11 = _RAND_70[5:0];
  _RAND_71 = {1{`RANDOM}};
  palette_sync_12 = _RAND_71[5:0];
  _RAND_72 = {1{`RANDOM}};
  palette_sync_13 = _RAND_72[5:0];
  _RAND_73 = {1{`RANDOM}};
  palette_sync_14 = _RAND_73[5:0];
  _RAND_74 = {1{`RANDOM}};
  palette_sync_15 = _RAND_74[5:0];
  _RAND_75 = {1{`RANDOM}};
  in_display_d1 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  h_active_d1 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  v_active_d1 = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  h_active_d2 = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  v_active_d2 = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  pixel_in_word_d1 = _RAND_80[2:0];
  _RAND_81 = {1{`RANDOM}};
  x_px_d1 = _RAND_81[9:0];
  _RAND_82 = {1{`RANDOM}};
  y_px_d1 = _RAND_82[9:0];
  _RAND_83 = {1{`RANDOM}};
  timing_err_toggle = _RAND_83[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Tx(
  input        clock,
  input        reset,
  output       io_txd, // @[4-soc/src/main/scala/peripheral/UART.scala 44:14]
  output       io_channel_ready, // @[4-soc/src/main/scala/peripheral/UART.scala 44:14]
  input        io_channel_valid, // @[4-soc/src/main/scala/peripheral/UART.scala 44:14]
  input  [7:0] io_channel_bits // @[4-soc/src/main/scala/peripheral/UART.scala 44:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] shiftReg; // @[4-soc/src/main/scala/peripheral/UART.scala 52:25]
  reg [15:0] cntReg; // @[4-soc/src/main/scala/peripheral/UART.scala 53:25]
  reg [3:0] bitsReg; // @[4-soc/src/main/scala/peripheral/UART.scala 54:25]
  wire  _io_channel_ready_T = cntReg == 16'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 56:31]
  wire [9:0] shift = shiftReg[10:1]; // @[4-soc/src/main/scala/peripheral/UART.scala 62:28]
  wire [10:0] _shiftReg_T_1 = {1'h1,shift}; // @[4-soc/src/main/scala/peripheral/UART.scala 63:22]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[4-soc/src/main/scala/peripheral/UART.scala 64:27]
  wire [10:0] _shiftReg_T_3 = {2'h3,io_channel_bits,1'h0}; // @[4-soc/src/main/scala/peripheral/UART.scala 69:24]
  wire [15:0] _cntReg_T_1 = cntReg - 16'h1; // @[4-soc/src/main/scala/peripheral/UART.scala 76:22]
  assign io_txd = shiftReg[0]; // @[4-soc/src/main/scala/peripheral/UART.scala 57:31]
  assign io_channel_ready = cntReg == 16'h0 & bitsReg == 4'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 56:40]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/peripheral/UART.scala 52:25]
      shiftReg <= 11'h7ff; // @[4-soc/src/main/scala/peripheral/UART.scala 52:25]
    end else if (_io_channel_ready_T) begin // @[4-soc/src/main/scala/peripheral/UART.scala 59:24]
      if (bitsReg != 4'h0) begin // @[4-soc/src/main/scala/peripheral/UART.scala 61:27]
        shiftReg <= _shiftReg_T_1; // @[4-soc/src/main/scala/peripheral/UART.scala 63:16]
      end else if (io_channel_valid) begin // @[4-soc/src/main/scala/peripheral/UART.scala 66:30]
        shiftReg <= _shiftReg_T_3; // @[4-soc/src/main/scala/peripheral/UART.scala 69:18]
      end else begin
        shiftReg <= 11'h7ff; // @[4-soc/src/main/scala/peripheral/UART.scala 72:18]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/UART.scala 53:25]
      cntReg <= 16'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 53:25]
    end else if (_io_channel_ready_T) begin // @[4-soc/src/main/scala/peripheral/UART.scala 59:24]
      cntReg <= 16'h1b1; // @[4-soc/src/main/scala/peripheral/UART.scala 60:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[4-soc/src/main/scala/peripheral/UART.scala 76:12]
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/UART.scala 54:25]
      bitsReg <= 4'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 54:25]
    end else if (_io_channel_ready_T) begin // @[4-soc/src/main/scala/peripheral/UART.scala 59:24]
      if (bitsReg != 4'h0) begin // @[4-soc/src/main/scala/peripheral/UART.scala 61:27]
        bitsReg <= _bitsReg_T_1; // @[4-soc/src/main/scala/peripheral/UART.scala 64:16]
      end else if (io_channel_valid) begin // @[4-soc/src/main/scala/peripheral/UART.scala 66:30]
        bitsReg <= 4'hb; // @[4-soc/src/main/scala/peripheral/UART.scala 70:18]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  shiftReg = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  cntReg = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  bitsReg = _RAND_2[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Buffer(
  input        clock,
  input        reset,
  output       io_in_ready, // @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
  input        io_in_valid, // @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
  input  [7:0] io_in_bits, // @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
  input        io_out_ready, // @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
  output       io_out_valid, // @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
  output [7:0] io_out_bits // @[4-soc/src/main/scala/peripheral/UART.scala 134:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[4-soc/src/main/scala/peripheral/UART.scala 140:37]
  reg [7:0] dataReg; // @[4-soc/src/main/scala/peripheral/UART.scala 141:37]
  wire  _io_in_ready_T = ~stateReg; // @[4-soc/src/main/scala/peripheral/UART.scala 143:28]
  wire  _GEN_1 = io_in_valid | stateReg; // @[4-soc/src/main/scala/peripheral/UART.scala 147:23 149:16 140:37]
  assign io_in_ready = ~stateReg; // @[4-soc/src/main/scala/peripheral/UART.scala 143:28]
  assign io_out_valid = stateReg; // @[4-soc/src/main/scala/peripheral/UART.scala 144:28]
  assign io_out_bits = dataReg; // @[4-soc/src/main/scala/peripheral/UART.scala 156:15]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/peripheral/UART.scala 140:37]
      stateReg <= 1'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 140:37]
    end else if (_io_in_ready_T) begin // @[4-soc/src/main/scala/peripheral/UART.scala 146:28]
      stateReg <= _GEN_1;
    end else if (io_out_ready) begin // @[4-soc/src/main/scala/peripheral/UART.scala 152:24]
      stateReg <= 1'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 153:16]
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/UART.scala 141:37]
      dataReg <= 8'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 141:37]
    end else if (_io_in_ready_T) begin // @[4-soc/src/main/scala/peripheral/UART.scala 146:28]
      if (io_in_valid) begin // @[4-soc/src/main/scala/peripheral/UART.scala 147:23]
        dataReg <= io_in_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 148:16]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BufferedTx(
  input        clock,
  input        reset,
  output       io_txd, // @[4-soc/src/main/scala/peripheral/UART.scala 163:14]
  output       io_channel_ready, // @[4-soc/src/main/scala/peripheral/UART.scala 163:14]
  input        io_channel_valid, // @[4-soc/src/main/scala/peripheral/UART.scala 163:14]
  input  [7:0] io_channel_bits // @[4-soc/src/main/scala/peripheral/UART.scala 163:14]
);
  wire  tx_clock; // @[4-soc/src/main/scala/peripheral/UART.scala 167:19]
  wire  tx_reset; // @[4-soc/src/main/scala/peripheral/UART.scala 167:19]
  wire  tx_io_txd; // @[4-soc/src/main/scala/peripheral/UART.scala 167:19]
  wire  tx_io_channel_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 167:19]
  wire  tx_io_channel_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 167:19]
  wire [7:0] tx_io_channel_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 167:19]
  wire  buf__clock; // @[4-soc/src/main/scala/peripheral/UART.scala 168:19]
  wire  buf__reset; // @[4-soc/src/main/scala/peripheral/UART.scala 168:19]
  wire  buf__io_in_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 168:19]
  wire  buf__io_in_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 168:19]
  wire [7:0] buf__io_in_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 168:19]
  wire  buf__io_out_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 168:19]
  wire  buf__io_out_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 168:19]
  wire [7:0] buf__io_out_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 168:19]
  Tx tx ( // @[4-soc/src/main/scala/peripheral/UART.scala 167:19]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_txd(tx_io_txd),
    .io_channel_ready(tx_io_channel_ready),
    .io_channel_valid(tx_io_channel_valid),
    .io_channel_bits(tx_io_channel_bits)
  );
  Buffer buf_ ( // @[4-soc/src/main/scala/peripheral/UART.scala 168:19]
    .clock(buf__clock),
    .reset(buf__reset),
    .io_in_ready(buf__io_in_ready),
    .io_in_valid(buf__io_in_valid),
    .io_in_bits(buf__io_in_bits),
    .io_out_ready(buf__io_out_ready),
    .io_out_valid(buf__io_out_valid),
    .io_out_bits(buf__io_out_bits)
  );
  assign io_txd = tx_io_txd; // @[4-soc/src/main/scala/peripheral/UART.scala 172:10]
  assign io_channel_ready = buf__io_in_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 170:13]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_channel_valid = buf__io_out_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 171:17]
  assign tx_io_channel_bits = buf__io_out_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 171:17]
  assign buf__clock = clock;
  assign buf__reset = reset;
  assign buf__io_in_valid = io_channel_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 170:13]
  assign buf__io_in_bits = io_channel_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 170:13]
  assign buf__io_out_ready = tx_io_channel_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 171:17]
endmodule
module Rx(
  input        clock,
  input        reset,
  input        io_rxd, // @[4-soc/src/main/scala/peripheral/UART.scala 88:14]
  input        io_channel_ready, // @[4-soc/src/main/scala/peripheral/UART.scala 88:14]
  output       io_channel_valid, // @[4-soc/src/main/scala/peripheral/UART.scala 88:14]
  output [7:0] io_channel_bits // @[4-soc/src/main/scala/peripheral/UART.scala 88:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[4-soc/src/main/scala/peripheral/UART.scala 99:30]
  reg  rxReg; // @[4-soc/src/main/scala/peripheral/UART.scala 99:22]
  reg [7:0] shiftReg; // @[4-soc/src/main/scala/peripheral/UART.scala 101:25]
  reg [15:0] cntReg; // @[4-soc/src/main/scala/peripheral/UART.scala 102:25]
  reg [3:0] bitsReg; // @[4-soc/src/main/scala/peripheral/UART.scala 103:25]
  reg  valReg; // @[4-soc/src/main/scala/peripheral/UART.scala 104:25]
  wire [15:0] _cntReg_T_1 = cntReg - 16'h1; // @[4-soc/src/main/scala/peripheral/UART.scala 107:22]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[4-soc/src/main/scala/peripheral/UART.scala 110:20]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[4-soc/src/main/scala/peripheral/UART.scala 111:25]
  wire  _GEN_0 = bitsReg == 4'h1 | valReg; // @[4-soc/src/main/scala/peripheral/UART.scala 112:27 113:14 104:25]
  assign io_channel_valid = valReg; // @[4-soc/src/main/scala/peripheral/UART.scala 127:20]
  assign io_channel_bits = shiftReg; // @[4-soc/src/main/scala/peripheral/UART.scala 126:20]
  always @(posedge clock) begin
    rxReg_REG <= reset | io_rxd; // @[4-soc/src/main/scala/peripheral/UART.scala 99:{30,30,30}]
    rxReg <= reset | rxReg_REG; // @[4-soc/src/main/scala/peripheral/UART.scala 99:{22,22,22}]
    if (reset) begin // @[4-soc/src/main/scala/peripheral/UART.scala 101:25]
      shiftReg <= 8'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 101:25]
    end else if (!(cntReg != 16'h0)) begin // @[4-soc/src/main/scala/peripheral/UART.scala 106:24]
      if (bitsReg != 4'h0) begin // @[4-soc/src/main/scala/peripheral/UART.scala 108:31]
        shiftReg <= _shiftReg_T_1; // @[4-soc/src/main/scala/peripheral/UART.scala 110:14]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/UART.scala 102:25]
      cntReg <= 16'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 102:25]
    end else if (cntReg != 16'h0) begin // @[4-soc/src/main/scala/peripheral/UART.scala 106:24]
      cntReg <= _cntReg_T_1; // @[4-soc/src/main/scala/peripheral/UART.scala 107:12]
    end else if (bitsReg != 4'h0) begin // @[4-soc/src/main/scala/peripheral/UART.scala 108:31]
      cntReg <= 16'h1b1; // @[4-soc/src/main/scala/peripheral/UART.scala 109:14]
    end else if (~rxReg & ~valReg) begin // @[4-soc/src/main/scala/peripheral/UART.scala 115:40]
      cntReg <= 16'h28a; // @[4-soc/src/main/scala/peripheral/UART.scala 118:13]
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/UART.scala 103:25]
      bitsReg <= 4'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 103:25]
    end else if (!(cntReg != 16'h0)) begin // @[4-soc/src/main/scala/peripheral/UART.scala 106:24]
      if (bitsReg != 4'h0) begin // @[4-soc/src/main/scala/peripheral/UART.scala 108:31]
        bitsReg <= _bitsReg_T_1; // @[4-soc/src/main/scala/peripheral/UART.scala 111:14]
      end else if (~rxReg & ~valReg) begin // @[4-soc/src/main/scala/peripheral/UART.scala 115:40]
        bitsReg <= 4'h8; // @[4-soc/src/main/scala/peripheral/UART.scala 119:13]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/UART.scala 104:25]
      valReg <= 1'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 104:25]
    end else if (valReg & io_channel_ready) begin // @[4-soc/src/main/scala/peripheral/UART.scala 122:36]
      valReg <= 1'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 123:12]
    end else if (!(cntReg != 16'h0)) begin // @[4-soc/src/main/scala/peripheral/UART.scala 106:24]
      if (bitsReg != 4'h0) begin // @[4-soc/src/main/scala/peripheral/UART.scala 108:31]
        valReg <= _GEN_0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rxReg_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rxReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  shiftReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  cntReg = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  bitsReg = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  valReg = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue(
  input        clock,
  input        reset,
  output       io_enq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 278:14]
  input        io_enq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 278:14]
  input  [7:0] io_enq_bits, // @[src/main/scala/chisel3/util/Decoupled.scala 278:14]
  input        io_deq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 278:14]
  output       io_deq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 278:14]
  output [7:0] io_deq_bits, // @[src/main/scala/chisel3/util/Decoupled.scala 278:14]
  output [2:0] io_count // @[src/main/scala/chisel3/util/Decoupled.scala 278:14]
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:3]; // @[src/main/scala/chisel3/util/Decoupled.scala 279:95]
  wire  ram_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 279:95]
  wire [1:0] ram_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 279:95]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 279:95]
  wire [7:0] ram_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 279:95]
  wire [1:0] ram_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 279:95]
  wire  ram_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 279:95]
  wire  ram_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 279:95]
  reg [1:0] enq_ptr_value; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  reg [1:0] deq_ptr_value; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  reg  maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 282:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[src/main/scala/chisel3/util/Decoupled.scala 283:33]
  wire  empty = ptr_match & ~maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 284:25]
  wire  full = ptr_match & maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 285:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 57:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 57:35]
  wire [1:0] _value_T_1 = enq_ptr_value + 2'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  wire [1:0] _value_T_3 = deq_ptr_value + 2'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  wire [1:0] ptr_diff = enq_ptr_value - deq_ptr_value; // @[src/main/scala/chisel3/util/Decoupled.scala 332:32]
  wire [2:0] _io_count_T_1 = maybe_full & ptr_match ? 3'h4 : 3'h0; // @[src/main/scala/chisel3/util/Decoupled.scala 335:20]
  wire [2:0] _GEN_12 = {{1'd0}, ptr_diff}; // @[src/main/scala/chisel3/util/Decoupled.scala 335:62]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 279:95]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | ~full; // @[src/main/scala/chisel3/util/Decoupled.scala 309:16 329:{24,39}]
  assign io_deq_valid = ~empty; // @[src/main/scala/chisel3/util/Decoupled.scala 308:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 316:17]
  assign io_count = _io_count_T_1 | _GEN_12; // @[src/main/scala/chisel3/util/Decoupled.scala 335:62]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 279:95]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      enq_ptr_value <= 2'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (do_enq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 292:16]
      enq_ptr_value <= _value_T_1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      deq_ptr_value <= 2'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 296:16]
      deq_ptr_value <= _value_T_3; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Decoupled.scala 282:27]
      maybe_full <= 1'h0; // @[src/main/scala/chisel3/util/Decoupled.scala 282:27]
    end else if (do_enq != do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 299:27]
      maybe_full <= do_enq; // @[src/main/scala/chisel3/util/Decoupled.scala 300:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    ram[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Uart(
  input         clock,
  input         reset,
  input         io_channels_write_address_channel_AWVALID, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  output        io_channels_write_address_channel_AWREADY, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  input  [7:0]  io_channels_write_address_channel_AWADDR, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  input         io_channels_write_data_channel_WVALID, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  output        io_channels_write_data_channel_WREADY, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  input  [31:0] io_channels_write_data_channel_WDATA, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  output        io_channels_write_response_channel_BVALID, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  input         io_channels_write_response_channel_BREADY, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  input         io_channels_read_address_channel_ARVALID, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  output        io_channels_read_address_channel_ARREADY, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  input  [7:0]  io_channels_read_address_channel_ARADDR, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  output        io_channels_read_data_channel_RVALID, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  input         io_channels_read_data_channel_RREADY, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  output [31:0] io_channels_read_data_channel_RDATA, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  input         io_rxd, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  output        io_txd, // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
  output        io_signal_interrupt // @[4-soc/src/main/scala/peripheral/UART.scala 201:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  slave_clock; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_reset; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire [7:0] slave_io_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire [31:0] slave_io_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire [7:0] slave_io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire [31:0] slave_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire [7:0] slave_io_bundle_address; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_bundle_read; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire [31:0] slave_io_bundle_read_data; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_bundle_read_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  slave_io_bundle_write; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire [31:0] slave_io_bundle_write_data; // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
  wire  tx_clock; // @[4-soc/src/main/scala/peripheral/UART.scala 212:18]
  wire  tx_reset; // @[4-soc/src/main/scala/peripheral/UART.scala 212:18]
  wire  tx_io_txd; // @[4-soc/src/main/scala/peripheral/UART.scala 212:18]
  wire  tx_io_channel_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 212:18]
  wire  tx_io_channel_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 212:18]
  wire [7:0] tx_io_channel_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 212:18]
  wire  rx_clock; // @[4-soc/src/main/scala/peripheral/UART.scala 213:18]
  wire  rx_reset; // @[4-soc/src/main/scala/peripheral/UART.scala 213:18]
  wire  rx_io_rxd; // @[4-soc/src/main/scala/peripheral/UART.scala 213:18]
  wire  rx_io_channel_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 213:18]
  wire  rx_io_channel_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 213:18]
  wire [7:0] rx_io_channel_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 213:18]
  wire  rxFifo_clock; // @[4-soc/src/main/scala/peripheral/UART.scala 217:22]
  wire  rxFifo_reset; // @[4-soc/src/main/scala/peripheral/UART.scala 217:22]
  wire  rxFifo_io_enq_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 217:22]
  wire  rxFifo_io_enq_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 217:22]
  wire [7:0] rxFifo_io_enq_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 217:22]
  wire  rxFifo_io_deq_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 217:22]
  wire  rxFifo_io_deq_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 217:22]
  wire [7:0] rxFifo_io_deq_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 217:22]
  wire [2:0] rxFifo_io_count; // @[4-soc/src/main/scala/peripheral/UART.scala 217:22]
  reg  interrupt; // @[4-soc/src/main/scala/peripheral/UART.scala 208:26]
  wire [7:0] addr = slave_io_bundle_address; // @[4-soc/src/main/scala/peripheral/UART.scala 221:48]
  wire  addr_status = addr == 8'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 222:29]
  wire  addr_baud_rate = addr == 8'h4; // @[4-soc/src/main/scala/peripheral/UART.scala 223:29]
  wire  addr_interrupt = addr == 8'h8; // @[4-soc/src/main/scala/peripheral/UART.scala 224:29]
  wire  addr_rx_data = addr == 8'hc; // @[4-soc/src/main/scala/peripheral/UART.scala 225:29]
  wire  addr_tx_data = addr == 8'h10; // @[4-soc/src/main/scala/peripheral/UART.scala 226:29]
  wire [31:0] _read_data_prepared_T = {30'h0,rxFifo_io_deq_valid,tx_io_channel_ready}; // @[4-soc/src/main/scala/peripheral/UART.scala 236:30]
  wire [31:0] _GEN_0 = addr_rx_data ? {{24'd0}, rxFifo_io_deq_bits} : 32'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 239:28 240:24 230:39]
  wire [31:0] _GEN_1 = addr_baud_rate ? 32'h1c200 : _GEN_0; // @[4-soc/src/main/scala/peripheral/UART.scala 237:30 238:24]
  wire  _rxFifo_io_deq_ready_T = slave_io_bundle_read & addr_rx_data; // @[4-soc/src/main/scala/peripheral/UART.scala 246:47]
  wire  _T_1 = rxFifo_io_enq_ready & rxFifo_io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 57:35]
  wire  _GEN_3 = rxFifo_io_count == 3'h1 ? 1'h0 : interrupt; // @[4-soc/src/main/scala/peripheral/UART.scala 261:35 262:17 208:26]
  wire  _GEN_4 = _rxFifo_io_deq_ready_T & rxFifo_io_deq_valid ? _GEN_3 : interrupt; // @[4-soc/src/main/scala/peripheral/UART.scala 208:26 258:75]
  wire  _GEN_5 = _T_1 | _GEN_4; // @[4-soc/src/main/scala/peripheral/UART.scala 255:34 257:15]
  wire  _T_5 = addr_tx_data & tx_io_channel_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 270:23]
  wire [7:0] _GEN_8 = addr_tx_data & tx_io_channel_ready ? slave_io_bundle_write_data[7:0] : 8'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 268:23 270:47 275:26]
  AXI4LiteSlave_1 slave ( // @[4-soc/src/main/scala/peripheral/UART.scala 209:25]
    .clock(slave_clock),
    .reset(slave_reset),
    .io_channels_write_address_channel_AWVALID(slave_io_channels_write_address_channel_AWVALID),
    .io_channels_write_address_channel_AWREADY(slave_io_channels_write_address_channel_AWREADY),
    .io_channels_write_address_channel_AWADDR(slave_io_channels_write_address_channel_AWADDR),
    .io_channels_write_data_channel_WVALID(slave_io_channels_write_data_channel_WVALID),
    .io_channels_write_data_channel_WREADY(slave_io_channels_write_data_channel_WREADY),
    .io_channels_write_data_channel_WDATA(slave_io_channels_write_data_channel_WDATA),
    .io_channels_write_response_channel_BVALID(slave_io_channels_write_response_channel_BVALID),
    .io_channels_write_response_channel_BREADY(slave_io_channels_write_response_channel_BREADY),
    .io_channels_read_address_channel_ARVALID(slave_io_channels_read_address_channel_ARVALID),
    .io_channels_read_address_channel_ARREADY(slave_io_channels_read_address_channel_ARREADY),
    .io_channels_read_address_channel_ARADDR(slave_io_channels_read_address_channel_ARADDR),
    .io_channels_read_data_channel_RVALID(slave_io_channels_read_data_channel_RVALID),
    .io_channels_read_data_channel_RREADY(slave_io_channels_read_data_channel_RREADY),
    .io_channels_read_data_channel_RDATA(slave_io_channels_read_data_channel_RDATA),
    .io_bundle_address(slave_io_bundle_address),
    .io_bundle_read(slave_io_bundle_read),
    .io_bundle_read_data(slave_io_bundle_read_data),
    .io_bundle_read_valid(slave_io_bundle_read_valid),
    .io_bundle_write(slave_io_bundle_write),
    .io_bundle_write_data(slave_io_bundle_write_data)
  );
  BufferedTx tx ( // @[4-soc/src/main/scala/peripheral/UART.scala 212:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_txd(tx_io_txd),
    .io_channel_ready(tx_io_channel_ready),
    .io_channel_valid(tx_io_channel_valid),
    .io_channel_bits(tx_io_channel_bits)
  );
  Rx rx ( // @[4-soc/src/main/scala/peripheral/UART.scala 213:18]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rxd(rx_io_rxd),
    .io_channel_ready(rx_io_channel_ready),
    .io_channel_valid(rx_io_channel_valid),
    .io_channel_bits(rx_io_channel_bits)
  );
  Queue rxFifo ( // @[4-soc/src/main/scala/peripheral/UART.scala 217:22]
    .clock(rxFifo_clock),
    .reset(rxFifo_reset),
    .io_enq_ready(rxFifo_io_enq_ready),
    .io_enq_valid(rxFifo_io_enq_valid),
    .io_enq_bits(rxFifo_io_enq_bits),
    .io_deq_ready(rxFifo_io_deq_ready),
    .io_deq_valid(rxFifo_io_deq_valid),
    .io_deq_bits(rxFifo_io_deq_bits),
    .io_count(rxFifo_io_count)
  );
  assign io_channels_write_address_channel_AWREADY = slave_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign io_channels_write_data_channel_WREADY = slave_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign io_channels_write_response_channel_BVALID = slave_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign io_channels_read_address_channel_ARREADY = slave_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign io_channels_read_data_channel_RVALID = slave_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign io_channels_read_data_channel_RDATA = slave_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign io_txd = tx_io_txd; // @[4-soc/src/main/scala/peripheral/UART.scala 281:23]
  assign io_signal_interrupt = interrupt; // @[4-soc/src/main/scala/peripheral/UART.scala 283:23]
  assign slave_clock = clock;
  assign slave_reset = reset;
  assign slave_io_channels_write_address_channel_AWVALID = io_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign slave_io_channels_write_address_channel_AWADDR = io_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign slave_io_channels_write_data_channel_WVALID = io_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign slave_io_channels_write_data_channel_WDATA = io_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign slave_io_channels_write_response_channel_BREADY = io_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign slave_io_channels_read_address_channel_ARVALID = io_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign slave_io_channels_read_address_channel_ARADDR = io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign slave_io_channels_read_data_channel_RREADY = io_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/peripheral/UART.scala 210:21]
  assign slave_io_bundle_read_data = addr_status ? _read_data_prepared_T : _GEN_1; // @[4-soc/src/main/scala/peripheral/UART.scala 234:21 236:24]
  assign slave_io_bundle_read_valid = slave_io_bundle_read; // @[4-soc/src/main/scala/peripheral/UART.scala 231:30]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_channel_valid = slave_io_bundle_write & _T_5; // @[4-soc/src/main/scala/peripheral/UART.scala 267:23 269:31]
  assign tx_io_channel_bits = slave_io_bundle_write ? _GEN_8 : 8'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 268:23 269:31]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rxd = io_rxd; // @[4-soc/src/main/scala/peripheral/UART.scala 282:23]
  assign rx_io_channel_ready = rxFifo_io_enq_ready; // @[4-soc/src/main/scala/peripheral/UART.scala 244:17]
  assign rxFifo_clock = clock;
  assign rxFifo_reset = reset;
  assign rxFifo_io_enq_valid = rx_io_channel_valid; // @[4-soc/src/main/scala/peripheral/UART.scala 244:17]
  assign rxFifo_io_enq_bits = rx_io_channel_bits; // @[4-soc/src/main/scala/peripheral/UART.scala 244:17]
  assign rxFifo_io_deq_ready = slave_io_bundle_read & addr_rx_data; // @[4-soc/src/main/scala/peripheral/UART.scala 246:47]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/peripheral/UART.scala 208:26]
      interrupt <= 1'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 208:26]
    end else if (slave_io_bundle_write & addr_interrupt) begin // @[4-soc/src/main/scala/peripheral/UART.scala 252:49]
      interrupt <= slave_io_bundle_write_data != 32'h0; // @[4-soc/src/main/scala/peripheral/UART.scala 254:15]
    end else begin
      interrupt <= _GEN_5;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  interrupt = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Control(
  input        io_jump_flag, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input        io_jump_instruction_id, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input  [4:0] io_rs1_id, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input  [4:0] io_rs2_id, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input        io_memory_read_enable_ex, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input  [4:0] io_rd_ex, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input        io_memory_read_enable_mem, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input  [4:0] io_rd_mem, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input        io_memory_write_enable_mem, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input  [1:0] io_regs_write_source_ex, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input  [1:0] io_regs_write_source_mem, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input  [1:0] io_regs_write_source_wb, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  input  [4:0] io_rd_wb, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  output       io_if_flush, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  output       io_id_flush, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  output       io_pc_stall, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  output       io_if_stall, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  output       io_branch_hazard, // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
  output       io_jal_jalr_hazard // @[4-soc/src/main/scala/riscv/core/Control.scala 217:14]
);
  wire  _ex_hazard_for_branch_T = io_rd_ex != 5'h0; // @[4-soc/src/main/scala/riscv/core/Control.scala 258:14]
  wire  _ex_hazard_for_branch_T_1 = io_jump_instruction_id & _ex_hazard_for_branch_T; // @[4-soc/src/main/scala/riscv/core/Control.scala 257:53]
  wire  _ex_hazard_for_branch_T_4 = io_rd_ex == io_rs1_id | io_rd_ex == io_rs2_id; // @[4-soc/src/main/scala/riscv/core/Control.scala 259:29]
  wire  ex_hazard_for_branch = _ex_hazard_for_branch_T_1 & _ex_hazard_for_branch_T_4; // @[4-soc/src/main/scala/riscv/core/Control.scala 258:22]
  wire  store_load_hazard = io_memory_write_enable_mem & io_memory_read_enable_ex; // @[4-soc/src/main/scala/riscv/core/Control.scala 273:54]
  wire  _jal_jalr_hazard_ex_T_2 = io_regs_write_source_ex == 2'h3 & _ex_hazard_for_branch_T; // @[4-soc/src/main/scala/riscv/core/Control.scala 287:96]
  wire  jal_jalr_hazard_ex = _jal_jalr_hazard_ex_T_2 & _ex_hazard_for_branch_T_4; // @[4-soc/src/main/scala/riscv/core/Control.scala 288:22]
  wire  _jal_jalr_hazard_mem_T_1 = io_rd_mem != 5'h0; // @[4-soc/src/main/scala/riscv/core/Control.scala 302:15]
  wire  _jal_jalr_hazard_mem_T_2 = io_regs_write_source_mem == 2'h3 & _jal_jalr_hazard_mem_T_1; // @[4-soc/src/main/scala/riscv/core/Control.scala 301:98]
  wire  _jal_jalr_hazard_mem_T_5 = io_rd_mem == io_rs1_id | io_rd_mem == io_rs2_id; // @[4-soc/src/main/scala/riscv/core/Control.scala 303:30]
  wire  jal_jalr_hazard_mem = _jal_jalr_hazard_mem_T_2 & _jal_jalr_hazard_mem_T_5; // @[4-soc/src/main/scala/riscv/core/Control.scala 302:23]
  wire  _jal_jalr_hazard_wb_T_1 = io_rd_wb != 5'h0; // @[4-soc/src/main/scala/riscv/core/Control.scala 319:14]
  wire  _jal_jalr_hazard_wb_T_2 = io_regs_write_source_wb == 2'h3 & _jal_jalr_hazard_wb_T_1; // @[4-soc/src/main/scala/riscv/core/Control.scala 318:96]
  wire  _jal_jalr_hazard_wb_T_5 = io_rd_wb == io_rs1_id | io_rd_wb == io_rs2_id; // @[4-soc/src/main/scala/riscv/core/Control.scala 320:29]
  wire  jal_jalr_hazard_wb = _jal_jalr_hazard_wb_T_2 & _jal_jalr_hazard_wb_T_5; // @[4-soc/src/main/scala/riscv/core/Control.scala 319:22]
  wire  _T_2 = (io_jump_instruction_id | io_memory_read_enable_ex) & _ex_hazard_for_branch_T; // @[4-soc/src/main/scala/riscv/core/Control.scala 328:59]
  wire  _T_6 = _T_2 & _ex_hazard_for_branch_T_4; // @[4-soc/src/main/scala/riscv/core/Control.scala 331:24]
  wire  _T_7 = io_jump_instruction_id & io_memory_read_enable_mem; // @[4-soc/src/main/scala/riscv/core/Control.scala 342:33]
  wire  _T_9 = _T_7 & _jal_jalr_hazard_mem_T_1; // @[4-soc/src/main/scala/riscv/core/Control.scala 343:37]
  wire  _T_13 = _T_9 & _jal_jalr_hazard_mem_T_5; // @[4-soc/src/main/scala/riscv/core/Control.scala 344:29]
  wire  _T_14 = _T_6 | _T_13; // @[4-soc/src/main/scala/riscv/core/Control.scala 339:7]
  wire  _T_15 = _T_14 | store_load_hazard; // @[4-soc/src/main/scala/riscv/core/Control.scala 351:9]
  wire  _T_16 = _T_15 | jal_jalr_hazard_ex; // @[4-soc/src/main/scala/riscv/core/Control.scala 357:9]
  wire  _T_17 = _T_16 | jal_jalr_hazard_mem; // @[4-soc/src/main/scala/riscv/core/Control.scala 363:9]
  wire  _T_18 = _T_17 | jal_jalr_hazard_wb; // @[4-soc/src/main/scala/riscv/core/Control.scala 369:9]
  wire  _is_load_use_hazard_T_1 = io_memory_read_enable_ex & _ex_hazard_for_branch_T; // @[4-soc/src/main/scala/riscv/core/Control.scala 389:55]
  wire  is_load_use_hazard = _is_load_use_hazard_T_1 & _ex_hazard_for_branch_T_4; // @[4-soc/src/main/scala/riscv/core/Control.scala 390:24]
  wire  is_jal_jalr_hazard = jal_jalr_hazard_ex | jal_jalr_hazard_mem | jal_jalr_hazard_wb; // @[4-soc/src/main/scala/riscv/core/Control.scala 394:72]
  assign io_if_flush = _T_18 ? 1'h0 : io_jump_flag; // @[4-soc/src/main/scala/riscv/core/Control.scala 248:22 374:5]
  assign io_id_flush = _T_18 & (is_load_use_hazard | is_jal_jalr_hazard); // @[4-soc/src/main/scala/riscv/core/Control.scala 374:5 395:17 249:22]
  assign io_pc_stall = _T_17 | jal_jalr_hazard_wb; // @[4-soc/src/main/scala/riscv/core/Control.scala 369:9]
  assign io_if_stall = _T_17 | jal_jalr_hazard_wb; // @[4-soc/src/main/scala/riscv/core/Control.scala 369:9]
  assign io_branch_hazard = _T_18 & (ex_hazard_for_branch | _T_13); // @[4-soc/src/main/scala/riscv/core/Control.scala 252:22 374:5 405:22]
  assign io_jal_jalr_hazard = _T_18 & is_jal_jalr_hazard; // @[4-soc/src/main/scala/riscv/core/Control.scala 253:22 374:5 407:24]
endmodule
module RegisterFile(
  input         clock,
  input         reset,
  input         io_write_enable, // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 22:14]
  input  [4:0]  io_write_address, // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 22:14]
  input  [31:0] io_write_data, // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 22:14]
  input  [4:0]  io_read_address1, // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 22:14]
  input  [4:0]  io_read_address2, // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 22:14]
  output [31:0] io_read_data1, // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 22:14]
  output [31:0] io_read_data2, // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 22:14]
  input  [4:0]  io_debug_read_address, // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 22:14]
  output [31:0] io_debug_read_data // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 22:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] registers_0; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_1; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_2; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_3; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_4; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_5; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_6; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_7; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_8; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_9; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_10; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_11; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_12; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_13; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_14; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_15; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_16; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_17; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_18; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_19; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_20; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_21; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_22; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_23; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_24; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_25; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_26; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_27; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_28; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_29; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  reg [31:0] registers_30; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 37:22]
  wire [4:0] _T_5 = io_write_address - 5'h1; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:34]
  wire  _io_read_data1_T = io_read_address1 == 5'h0; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 50:22]
  wire  _io_read_data1_T_2 = io_write_enable & io_write_address == io_read_address1; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 53:23]
  wire [4:0] _io_read_data1_T_4 = io_read_address1 - 5'h1; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 55:34]
  wire [31:0] _GEN_94 = 5'h1 == _io_read_data1_T_4 ? registers_1 : registers_0; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_95 = 5'h2 == _io_read_data1_T_4 ? registers_2 : _GEN_94; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_96 = 5'h3 == _io_read_data1_T_4 ? registers_3 : _GEN_95; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_97 = 5'h4 == _io_read_data1_T_4 ? registers_4 : _GEN_96; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_98 = 5'h5 == _io_read_data1_T_4 ? registers_5 : _GEN_97; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_99 = 5'h6 == _io_read_data1_T_4 ? registers_6 : _GEN_98; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_100 = 5'h7 == _io_read_data1_T_4 ? registers_7 : _GEN_99; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_101 = 5'h8 == _io_read_data1_T_4 ? registers_8 : _GEN_100; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_102 = 5'h9 == _io_read_data1_T_4 ? registers_9 : _GEN_101; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_103 = 5'ha == _io_read_data1_T_4 ? registers_10 : _GEN_102; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_104 = 5'hb == _io_read_data1_T_4 ? registers_11 : _GEN_103; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_105 = 5'hc == _io_read_data1_T_4 ? registers_12 : _GEN_104; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_106 = 5'hd == _io_read_data1_T_4 ? registers_13 : _GEN_105; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_107 = 5'he == _io_read_data1_T_4 ? registers_14 : _GEN_106; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_108 = 5'hf == _io_read_data1_T_4 ? registers_15 : _GEN_107; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_109 = 5'h10 == _io_read_data1_T_4 ? registers_16 : _GEN_108; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_110 = 5'h11 == _io_read_data1_T_4 ? registers_17 : _GEN_109; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_111 = 5'h12 == _io_read_data1_T_4 ? registers_18 : _GEN_110; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_112 = 5'h13 == _io_read_data1_T_4 ? registers_19 : _GEN_111; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_113 = 5'h14 == _io_read_data1_T_4 ? registers_20 : _GEN_112; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_114 = 5'h15 == _io_read_data1_T_4 ? registers_21 : _GEN_113; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_115 = 5'h16 == _io_read_data1_T_4 ? registers_22 : _GEN_114; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_116 = 5'h17 == _io_read_data1_T_4 ? registers_23 : _GEN_115; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_117 = 5'h18 == _io_read_data1_T_4 ? registers_24 : _GEN_116; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_118 = 5'h19 == _io_read_data1_T_4 ? registers_25 : _GEN_117; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_119 = 5'h1a == _io_read_data1_T_4 ? registers_26 : _GEN_118; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_120 = 5'h1b == _io_read_data1_T_4 ? registers_27 : _GEN_119; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_121 = 5'h1c == _io_read_data1_T_4 ? registers_28 : _GEN_120; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_122 = 5'h1d == _io_read_data1_T_4 ? registers_29 : _GEN_121; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _GEN_123 = 5'h1e == _io_read_data1_T_4 ? registers_30 : _GEN_122; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:{8,8}]
  wire [31:0] _io_read_data1_T_5 = _io_read_data1_T_2 ? io_write_data : _GEN_123; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 52:8]
  wire  _io_read_data2_T = io_read_address2 == 5'h0; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 60:22]
  wire  _io_read_data2_T_2 = io_write_enable & io_write_address == io_read_address2; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 63:23]
  wire [4:0] _io_read_data2_T_4 = io_read_address2 - 5'h1; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 65:34]
  wire [31:0] _GEN_125 = 5'h1 == _io_read_data2_T_4 ? registers_1 : registers_0; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_126 = 5'h2 == _io_read_data2_T_4 ? registers_2 : _GEN_125; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_127 = 5'h3 == _io_read_data2_T_4 ? registers_3 : _GEN_126; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_128 = 5'h4 == _io_read_data2_T_4 ? registers_4 : _GEN_127; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_129 = 5'h5 == _io_read_data2_T_4 ? registers_5 : _GEN_128; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_130 = 5'h6 == _io_read_data2_T_4 ? registers_6 : _GEN_129; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_131 = 5'h7 == _io_read_data2_T_4 ? registers_7 : _GEN_130; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_132 = 5'h8 == _io_read_data2_T_4 ? registers_8 : _GEN_131; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_133 = 5'h9 == _io_read_data2_T_4 ? registers_9 : _GEN_132; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_134 = 5'ha == _io_read_data2_T_4 ? registers_10 : _GEN_133; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_135 = 5'hb == _io_read_data2_T_4 ? registers_11 : _GEN_134; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_136 = 5'hc == _io_read_data2_T_4 ? registers_12 : _GEN_135; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_137 = 5'hd == _io_read_data2_T_4 ? registers_13 : _GEN_136; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_138 = 5'he == _io_read_data2_T_4 ? registers_14 : _GEN_137; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_139 = 5'hf == _io_read_data2_T_4 ? registers_15 : _GEN_138; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_140 = 5'h10 == _io_read_data2_T_4 ? registers_16 : _GEN_139; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_141 = 5'h11 == _io_read_data2_T_4 ? registers_17 : _GEN_140; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_142 = 5'h12 == _io_read_data2_T_4 ? registers_18 : _GEN_141; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_143 = 5'h13 == _io_read_data2_T_4 ? registers_19 : _GEN_142; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_144 = 5'h14 == _io_read_data2_T_4 ? registers_20 : _GEN_143; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_145 = 5'h15 == _io_read_data2_T_4 ? registers_21 : _GEN_144; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_146 = 5'h16 == _io_read_data2_T_4 ? registers_22 : _GEN_145; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_147 = 5'h17 == _io_read_data2_T_4 ? registers_23 : _GEN_146; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_148 = 5'h18 == _io_read_data2_T_4 ? registers_24 : _GEN_147; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_149 = 5'h19 == _io_read_data2_T_4 ? registers_25 : _GEN_148; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_150 = 5'h1a == _io_read_data2_T_4 ? registers_26 : _GEN_149; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_151 = 5'h1b == _io_read_data2_T_4 ? registers_27 : _GEN_150; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_152 = 5'h1c == _io_read_data2_T_4 ? registers_28 : _GEN_151; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_153 = 5'h1d == _io_read_data2_T_4 ? registers_29 : _GEN_152; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _GEN_154 = 5'h1e == _io_read_data2_T_4 ? registers_30 : _GEN_153; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:{8,8}]
  wire [31:0] _io_read_data2_T_5 = _io_read_data2_T_2 ? io_write_data : _GEN_154; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 62:8]
  wire  _io_debug_read_data_T = io_debug_read_address == 5'h0; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 70:27]
  wire  _io_debug_read_data_T_2 = io_write_enable & io_write_address == io_debug_read_address; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 73:23]
  wire [4:0] _io_debug_read_data_T_4 = io_debug_read_address - 5'h1; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 75:39]
  wire [31:0] _GEN_156 = 5'h1 == _io_debug_read_data_T_4 ? registers_1 : registers_0; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_157 = 5'h2 == _io_debug_read_data_T_4 ? registers_2 : _GEN_156; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_158 = 5'h3 == _io_debug_read_data_T_4 ? registers_3 : _GEN_157; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_159 = 5'h4 == _io_debug_read_data_T_4 ? registers_4 : _GEN_158; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_160 = 5'h5 == _io_debug_read_data_T_4 ? registers_5 : _GEN_159; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_161 = 5'h6 == _io_debug_read_data_T_4 ? registers_6 : _GEN_160; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_162 = 5'h7 == _io_debug_read_data_T_4 ? registers_7 : _GEN_161; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_163 = 5'h8 == _io_debug_read_data_T_4 ? registers_8 : _GEN_162; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_164 = 5'h9 == _io_debug_read_data_T_4 ? registers_9 : _GEN_163; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_165 = 5'ha == _io_debug_read_data_T_4 ? registers_10 : _GEN_164; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_166 = 5'hb == _io_debug_read_data_T_4 ? registers_11 : _GEN_165; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_167 = 5'hc == _io_debug_read_data_T_4 ? registers_12 : _GEN_166; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_168 = 5'hd == _io_debug_read_data_T_4 ? registers_13 : _GEN_167; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_169 = 5'he == _io_debug_read_data_T_4 ? registers_14 : _GEN_168; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_170 = 5'hf == _io_debug_read_data_T_4 ? registers_15 : _GEN_169; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_171 = 5'h10 == _io_debug_read_data_T_4 ? registers_16 : _GEN_170; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_172 = 5'h11 == _io_debug_read_data_T_4 ? registers_17 : _GEN_171; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_173 = 5'h12 == _io_debug_read_data_T_4 ? registers_18 : _GEN_172; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_174 = 5'h13 == _io_debug_read_data_T_4 ? registers_19 : _GEN_173; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_175 = 5'h14 == _io_debug_read_data_T_4 ? registers_20 : _GEN_174; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_176 = 5'h15 == _io_debug_read_data_T_4 ? registers_21 : _GEN_175; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_177 = 5'h16 == _io_debug_read_data_T_4 ? registers_22 : _GEN_176; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_178 = 5'h17 == _io_debug_read_data_T_4 ? registers_23 : _GEN_177; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_179 = 5'h18 == _io_debug_read_data_T_4 ? registers_24 : _GEN_178; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_180 = 5'h19 == _io_debug_read_data_T_4 ? registers_25 : _GEN_179; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_181 = 5'h1a == _io_debug_read_data_T_4 ? registers_26 : _GEN_180; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_182 = 5'h1b == _io_debug_read_data_T_4 ? registers_27 : _GEN_181; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_183 = 5'h1c == _io_debug_read_data_T_4 ? registers_28 : _GEN_182; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_184 = 5'h1d == _io_debug_read_data_T_4 ? registers_29 : _GEN_183; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _GEN_185 = 5'h1e == _io_debug_read_data_T_4 ? registers_30 : _GEN_184; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:{8,8}]
  wire [31:0] _io_debug_read_data_T_5 = _io_debug_read_data_T_2 ? io_write_data : _GEN_185; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 72:8]
  assign io_read_data1 = _io_read_data1_T ? 32'h0 : _io_read_data1_T_5; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 49:23]
  assign io_read_data2 = _io_read_data2_T ? 32'h0 : _io_read_data2_T_5; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 59:23]
  assign io_debug_read_data = _io_debug_read_data_T ? 32'h0 : _io_debug_read_data_T_5; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 69:28]
  always @(posedge clock) begin
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h0 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_0 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h1 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_1 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h2 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_2 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h3 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_3 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h4 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_4 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h5 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_5 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h6 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_6 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h7 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_7 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h8 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_8 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h9 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_9 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'ha == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_10 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'hb == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_11 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'hc == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_12 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'hd == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_13 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'he == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_14 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'hf == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_15 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h10 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_16 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h11 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_17 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h12 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_18 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h13 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_19 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h14 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_20 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h15 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_21 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h16 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_22 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h17 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_23 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h18 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_24 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h19 == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_25 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h1a == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_26 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h1b == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_27 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h1c == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_28 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h1d == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_29 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
    if (~reset) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 39:23]
      if (io_write_enable & io_write_address != 5'h0) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 40:55]
        if (5'h1e == _T_5) begin // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
          registers_30 <= io_write_data; // @[4-soc/src/main/scala/riscv/core/RegisterFile.scala 42:41]
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  registers_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  registers_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  registers_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  registers_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  registers_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  registers_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  registers_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  registers_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  registers_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  registers_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  registers_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  registers_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  registers_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  registers_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  registers_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  registers_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  registers_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  registers_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  registers_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  registers_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  registers_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  registers_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  registers_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  registers_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  registers_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  registers_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  registers_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  registers_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  registers_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  registers_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  registers_30 = _RAND_30[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BranchTargetBuffer(
  input         clock,
  input         reset,
  input  [31:0] io_pc, // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 46:14]
  output [31:0] io_predicted_pc, // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 46:14]
  output        io_predicted_taken, // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 46:14]
  input         io_update_valid, // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 46:14]
  input  [31:0] io_update_pc, // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 46:14]
  input  [31:0] io_update_target, // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 46:14]
  input         io_update_taken // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 46:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
`endif // RANDOMIZE_REG_INIT
  reg  valid_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg  valid_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
  reg [24:0] tags_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [24:0] tags_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 61:20]
  reg [31:0] targets_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [31:0] targets_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 62:20]
  reg [1:0] counters_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  reg [1:0] counters_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
  wire [4:0] pred_index = io_pc[6:2]; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 69:36]
  wire [24:0] pred_tag = io_pc[31:7]; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 70:36]
  wire [24:0] _GEN_1 = 5'h1 == pred_index ? tags_1 : tags_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_2 = 5'h2 == pred_index ? tags_2 : _GEN_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_3 = 5'h3 == pred_index ? tags_3 : _GEN_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_4 = 5'h4 == pred_index ? tags_4 : _GEN_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_5 = 5'h5 == pred_index ? tags_5 : _GEN_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_6 = 5'h6 == pred_index ? tags_6 : _GEN_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_7 = 5'h7 == pred_index ? tags_7 : _GEN_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_8 = 5'h8 == pred_index ? tags_8 : _GEN_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_9 = 5'h9 == pred_index ? tags_9 : _GEN_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_10 = 5'ha == pred_index ? tags_10 : _GEN_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_11 = 5'hb == pred_index ? tags_11 : _GEN_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_12 = 5'hc == pred_index ? tags_12 : _GEN_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_13 = 5'hd == pred_index ? tags_13 : _GEN_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_14 = 5'he == pred_index ? tags_14 : _GEN_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_15 = 5'hf == pred_index ? tags_15 : _GEN_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_16 = 5'h10 == pred_index ? tags_16 : _GEN_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_17 = 5'h11 == pred_index ? tags_17 : _GEN_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_18 = 5'h12 == pred_index ? tags_18 : _GEN_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_19 = 5'h13 == pred_index ? tags_19 : _GEN_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_20 = 5'h14 == pred_index ? tags_20 : _GEN_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_21 = 5'h15 == pred_index ? tags_21 : _GEN_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_22 = 5'h16 == pred_index ? tags_22 : _GEN_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_23 = 5'h17 == pred_index ? tags_23 : _GEN_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_24 = 5'h18 == pred_index ? tags_24 : _GEN_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_25 = 5'h19 == pred_index ? tags_25 : _GEN_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_26 = 5'h1a == pred_index ? tags_26 : _GEN_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_27 = 5'h1b == pred_index ? tags_27 : _GEN_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_28 = 5'h1c == pred_index ? tags_28 : _GEN_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_29 = 5'h1d == pred_index ? tags_29 : _GEN_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_30 = 5'h1e == pred_index ? tags_30 : _GEN_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire [24:0] _GEN_31 = 5'h1f == pred_index ? tags_31 : _GEN_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{59,59}]
  wire  _GEN_33 = 5'h1 == pred_index ? valid_1 : valid_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_34 = 5'h2 == pred_index ? valid_2 : _GEN_33; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_35 = 5'h3 == pred_index ? valid_3 : _GEN_34; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_36 = 5'h4 == pred_index ? valid_4 : _GEN_35; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_37 = 5'h5 == pred_index ? valid_5 : _GEN_36; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_38 = 5'h6 == pred_index ? valid_6 : _GEN_37; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_39 = 5'h7 == pred_index ? valid_7 : _GEN_38; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_40 = 5'h8 == pred_index ? valid_8 : _GEN_39; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_41 = 5'h9 == pred_index ? valid_9 : _GEN_40; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_42 = 5'ha == pred_index ? valid_10 : _GEN_41; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_43 = 5'hb == pred_index ? valid_11 : _GEN_42; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_44 = 5'hc == pred_index ? valid_12 : _GEN_43; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_45 = 5'hd == pred_index ? valid_13 : _GEN_44; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_46 = 5'he == pred_index ? valid_14 : _GEN_45; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_47 = 5'hf == pred_index ? valid_15 : _GEN_46; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_48 = 5'h10 == pred_index ? valid_16 : _GEN_47; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_49 = 5'h11 == pred_index ? valid_17 : _GEN_48; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_50 = 5'h12 == pred_index ? valid_18 : _GEN_49; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_51 = 5'h13 == pred_index ? valid_19 : _GEN_50; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_52 = 5'h14 == pred_index ? valid_20 : _GEN_51; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_53 = 5'h15 == pred_index ? valid_21 : _GEN_52; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_54 = 5'h16 == pred_index ? valid_22 : _GEN_53; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_55 = 5'h17 == pred_index ? valid_23 : _GEN_54; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_56 = 5'h18 == pred_index ? valid_24 : _GEN_55; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_57 = 5'h19 == pred_index ? valid_25 : _GEN_56; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_58 = 5'h1a == pred_index ? valid_26 : _GEN_57; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_59 = 5'h1b == pred_index ? valid_27 : _GEN_58; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_60 = 5'h1c == pred_index ? valid_28 : _GEN_59; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_61 = 5'h1d == pred_index ? valid_29 : _GEN_60; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_62 = 5'h1e == pred_index ? valid_30 : _GEN_61; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  _GEN_63 = 5'h1f == pred_index ? valid_31 : _GEN_62; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:{38,38}]
  wire  hit = _GEN_63 & _GEN_31 == pred_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 75:38]
  wire [1:0] _GEN_65 = 5'h1 == pred_index ? counters_1 : counters_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_66 = 5'h2 == pred_index ? counters_2 : _GEN_65; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_67 = 5'h3 == pred_index ? counters_3 : _GEN_66; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_68 = 5'h4 == pred_index ? counters_4 : _GEN_67; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_69 = 5'h5 == pred_index ? counters_5 : _GEN_68; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_70 = 5'h6 == pred_index ? counters_6 : _GEN_69; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_71 = 5'h7 == pred_index ? counters_7 : _GEN_70; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_72 = 5'h8 == pred_index ? counters_8 : _GEN_71; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_73 = 5'h9 == pred_index ? counters_9 : _GEN_72; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_74 = 5'ha == pred_index ? counters_10 : _GEN_73; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_75 = 5'hb == pred_index ? counters_11 : _GEN_74; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_76 = 5'hc == pred_index ? counters_12 : _GEN_75; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_77 = 5'hd == pred_index ? counters_13 : _GEN_76; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_78 = 5'he == pred_index ? counters_14 : _GEN_77; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_79 = 5'hf == pred_index ? counters_15 : _GEN_78; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_80 = 5'h10 == pred_index ? counters_16 : _GEN_79; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_81 = 5'h11 == pred_index ? counters_17 : _GEN_80; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_82 = 5'h12 == pred_index ? counters_18 : _GEN_81; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_83 = 5'h13 == pred_index ? counters_19 : _GEN_82; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_84 = 5'h14 == pred_index ? counters_20 : _GEN_83; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_85 = 5'h15 == pred_index ? counters_21 : _GEN_84; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_86 = 5'h16 == pred_index ? counters_22 : _GEN_85; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_87 = 5'h17 == pred_index ? counters_23 : _GEN_86; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_88 = 5'h18 == pred_index ? counters_24 : _GEN_87; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_89 = 5'h19 == pred_index ? counters_25 : _GEN_88; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_90 = 5'h1a == pred_index ? counters_26 : _GEN_89; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_91 = 5'h1b == pred_index ? counters_27 : _GEN_90; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_92 = 5'h1c == pred_index ? counters_28 : _GEN_91; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_93 = 5'h1d == pred_index ? counters_29 : _GEN_92; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_94 = 5'h1e == pred_index ? counters_30 : _GEN_93; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire [1:0] _GEN_95 = 5'h1f == pred_index ? counters_31 : _GEN_94; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:{52,52}]
  wire  predict_taken = hit & _GEN_95 >= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:27]
  wire [31:0] _io_predicted_pc_T_1 = io_pc + 32'h4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:68]
  wire [31:0] _GEN_97 = 5'h1 == pred_index ? targets_1 : targets_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_98 = 5'h2 == pred_index ? targets_2 : _GEN_97; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_99 = 5'h3 == pred_index ? targets_3 : _GEN_98; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_100 = 5'h4 == pred_index ? targets_4 : _GEN_99; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_101 = 5'h5 == pred_index ? targets_5 : _GEN_100; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_102 = 5'h6 == pred_index ? targets_6 : _GEN_101; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_103 = 5'h7 == pred_index ? targets_7 : _GEN_102; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_104 = 5'h8 == pred_index ? targets_8 : _GEN_103; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_105 = 5'h9 == pred_index ? targets_9 : _GEN_104; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_106 = 5'ha == pred_index ? targets_10 : _GEN_105; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_107 = 5'hb == pred_index ? targets_11 : _GEN_106; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_108 = 5'hc == pred_index ? targets_12 : _GEN_107; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_109 = 5'hd == pred_index ? targets_13 : _GEN_108; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_110 = 5'he == pred_index ? targets_14 : _GEN_109; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_111 = 5'hf == pred_index ? targets_15 : _GEN_110; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_112 = 5'h10 == pred_index ? targets_16 : _GEN_111; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_113 = 5'h11 == pred_index ? targets_17 : _GEN_112; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_114 = 5'h12 == pred_index ? targets_18 : _GEN_113; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_115 = 5'h13 == pred_index ? targets_19 : _GEN_114; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_116 = 5'h14 == pred_index ? targets_20 : _GEN_115; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_117 = 5'h15 == pred_index ? targets_21 : _GEN_116; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_118 = 5'h16 == pred_index ? targets_22 : _GEN_117; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_119 = 5'h17 == pred_index ? targets_23 : _GEN_118; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_120 = 5'h18 == pred_index ? targets_24 : _GEN_119; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_121 = 5'h19 == pred_index ? targets_25 : _GEN_120; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_122 = 5'h1a == pred_index ? targets_26 : _GEN_121; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_123 = 5'h1b == pred_index ? targets_27 : _GEN_122; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_124 = 5'h1c == pred_index ? targets_28 : _GEN_123; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_125 = 5'h1d == pred_index ? targets_29 : _GEN_124; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_126 = 5'h1e == pred_index ? targets_30 : _GEN_125; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [31:0] _GEN_127 = 5'h1f == pred_index ? targets_31 : _GEN_126; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:{25,25}]
  wire [4:0] upd_index = io_update_pc[6:2]; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 69:36]
  wire [24:0] upd_tag = io_update_pc[31:7]; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 70:36]
  wire [24:0] _GEN_129 = 5'h1 == upd_index ? tags_1 : tags_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_130 = 5'h2 == upd_index ? tags_2 : _GEN_129; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_131 = 5'h3 == upd_index ? tags_3 : _GEN_130; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_132 = 5'h4 == upd_index ? tags_4 : _GEN_131; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_133 = 5'h5 == upd_index ? tags_5 : _GEN_132; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_134 = 5'h6 == upd_index ? tags_6 : _GEN_133; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_135 = 5'h7 == upd_index ? tags_7 : _GEN_134; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_136 = 5'h8 == upd_index ? tags_8 : _GEN_135; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_137 = 5'h9 == upd_index ? tags_9 : _GEN_136; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_138 = 5'ha == upd_index ? tags_10 : _GEN_137; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_139 = 5'hb == upd_index ? tags_11 : _GEN_138; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_140 = 5'hc == upd_index ? tags_12 : _GEN_139; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_141 = 5'hd == upd_index ? tags_13 : _GEN_140; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_142 = 5'he == upd_index ? tags_14 : _GEN_141; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_143 = 5'hf == upd_index ? tags_15 : _GEN_142; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_144 = 5'h10 == upd_index ? tags_16 : _GEN_143; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_145 = 5'h11 == upd_index ? tags_17 : _GEN_144; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_146 = 5'h12 == upd_index ? tags_18 : _GEN_145; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_147 = 5'h13 == upd_index ? tags_19 : _GEN_146; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_148 = 5'h14 == upd_index ? tags_20 : _GEN_147; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_149 = 5'h15 == upd_index ? tags_21 : _GEN_148; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_150 = 5'h16 == upd_index ? tags_22 : _GEN_149; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_151 = 5'h17 == upd_index ? tags_23 : _GEN_150; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_152 = 5'h18 == upd_index ? tags_24 : _GEN_151; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_153 = 5'h19 == upd_index ? tags_25 : _GEN_152; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_154 = 5'h1a == upd_index ? tags_26 : _GEN_153; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_155 = 5'h1b == upd_index ? tags_27 : _GEN_154; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_156 = 5'h1c == upd_index ? tags_28 : _GEN_155; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_157 = 5'h1d == upd_index ? tags_29 : _GEN_156; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_158 = 5'h1e == upd_index ? tags_30 : _GEN_157; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire [24:0] _GEN_159 = 5'h1f == upd_index ? tags_31 : _GEN_158; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{58,58}]
  wire  _GEN_161 = 5'h1 == upd_index ? valid_1 : valid_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_162 = 5'h2 == upd_index ? valid_2 : _GEN_161; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_163 = 5'h3 == upd_index ? valid_3 : _GEN_162; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_164 = 5'h4 == upd_index ? valid_4 : _GEN_163; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_165 = 5'h5 == upd_index ? valid_5 : _GEN_164; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_166 = 5'h6 == upd_index ? valid_6 : _GEN_165; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_167 = 5'h7 == upd_index ? valid_7 : _GEN_166; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_168 = 5'h8 == upd_index ? valid_8 : _GEN_167; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_169 = 5'h9 == upd_index ? valid_9 : _GEN_168; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_170 = 5'ha == upd_index ? valid_10 : _GEN_169; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_171 = 5'hb == upd_index ? valid_11 : _GEN_170; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_172 = 5'hc == upd_index ? valid_12 : _GEN_171; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_173 = 5'hd == upd_index ? valid_13 : _GEN_172; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_174 = 5'he == upd_index ? valid_14 : _GEN_173; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_175 = 5'hf == upd_index ? valid_15 : _GEN_174; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_176 = 5'h10 == upd_index ? valid_16 : _GEN_175; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_177 = 5'h11 == upd_index ? valid_17 : _GEN_176; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_178 = 5'h12 == upd_index ? valid_18 : _GEN_177; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_179 = 5'h13 == upd_index ? valid_19 : _GEN_178; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_180 = 5'h14 == upd_index ? valid_20 : _GEN_179; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_181 = 5'h15 == upd_index ? valid_21 : _GEN_180; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_182 = 5'h16 == upd_index ? valid_22 : _GEN_181; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_183 = 5'h17 == upd_index ? valid_23 : _GEN_182; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_184 = 5'h18 == upd_index ? valid_24 : _GEN_183; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_185 = 5'h19 == upd_index ? valid_25 : _GEN_184; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_186 = 5'h1a == upd_index ? valid_26 : _GEN_185; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_187 = 5'h1b == upd_index ? valid_27 : _GEN_186; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_188 = 5'h1c == upd_index ? valid_28 : _GEN_187; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_189 = 5'h1d == upd_index ? valid_29 : _GEN_188; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_190 = 5'h1e == upd_index ? valid_30 : _GEN_189; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  _GEN_191 = 5'h1f == upd_index ? valid_31 : _GEN_190; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:{38,38}]
  wire  entry_hit = _GEN_191 & _GEN_159 == upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 87:38]
  wire  _GEN_192 = 5'h0 == upd_index | valid_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_193 = 5'h1 == upd_index | valid_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_194 = 5'h2 == upd_index | valid_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_195 = 5'h3 == upd_index | valid_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_196 = 5'h4 == upd_index | valid_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_197 = 5'h5 == upd_index | valid_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_198 = 5'h6 == upd_index | valid_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_199 = 5'h7 == upd_index | valid_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_200 = 5'h8 == upd_index | valid_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_201 = 5'h9 == upd_index | valid_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_202 = 5'ha == upd_index | valid_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_203 = 5'hb == upd_index | valid_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_204 = 5'hc == upd_index | valid_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_205 = 5'hd == upd_index | valid_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_206 = 5'he == upd_index | valid_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_207 = 5'hf == upd_index | valid_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_208 = 5'h10 == upd_index | valid_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_209 = 5'h11 == upd_index | valid_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_210 = 5'h12 == upd_index | valid_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_211 = 5'h13 == upd_index | valid_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_212 = 5'h14 == upd_index | valid_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_213 = 5'h15 == upd_index | valid_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_214 = 5'h16 == upd_index | valid_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_215 = 5'h17 == upd_index | valid_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_216 = 5'h18 == upd_index | valid_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_217 = 5'h19 == upd_index | valid_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_218 = 5'h1a == upd_index | valid_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_219 = 5'h1b == upd_index | valid_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_220 = 5'h1c == upd_index | valid_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_221 = 5'h1d == upd_index | valid_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_222 = 5'h1e == upd_index | valid_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire  _GEN_223 = 5'h1f == upd_index | valid_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24 91:{26,26}]
  wire [1:0] _GEN_289 = 5'h1 == upd_index ? counters_1 : counters_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_290 = 5'h2 == upd_index ? counters_2 : _GEN_289; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_291 = 5'h3 == upd_index ? counters_3 : _GEN_290; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_292 = 5'h4 == upd_index ? counters_4 : _GEN_291; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_293 = 5'h5 == upd_index ? counters_5 : _GEN_292; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_294 = 5'h6 == upd_index ? counters_6 : _GEN_293; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_295 = 5'h7 == upd_index ? counters_7 : _GEN_294; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_296 = 5'h8 == upd_index ? counters_8 : _GEN_295; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_297 = 5'h9 == upd_index ? counters_9 : _GEN_296; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_298 = 5'ha == upd_index ? counters_10 : _GEN_297; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_299 = 5'hb == upd_index ? counters_11 : _GEN_298; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_300 = 5'hc == upd_index ? counters_12 : _GEN_299; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_301 = 5'hd == upd_index ? counters_13 : _GEN_300; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_302 = 5'he == upd_index ? counters_14 : _GEN_301; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_303 = 5'hf == upd_index ? counters_15 : _GEN_302; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_304 = 5'h10 == upd_index ? counters_16 : _GEN_303; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_305 = 5'h11 == upd_index ? counters_17 : _GEN_304; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_306 = 5'h12 == upd_index ? counters_18 : _GEN_305; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_307 = 5'h13 == upd_index ? counters_19 : _GEN_306; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_308 = 5'h14 == upd_index ? counters_20 : _GEN_307; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_309 = 5'h15 == upd_index ? counters_21 : _GEN_308; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_310 = 5'h16 == upd_index ? counters_22 : _GEN_309; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_311 = 5'h17 == upd_index ? counters_23 : _GEN_310; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_312 = 5'h18 == upd_index ? counters_24 : _GEN_311; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_313 = 5'h19 == upd_index ? counters_25 : _GEN_312; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_314 = 5'h1a == upd_index ? counters_26 : _GEN_313; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_315 = 5'h1b == upd_index ? counters_27 : _GEN_314; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_316 = 5'h1c == upd_index ? counters_28 : _GEN_315; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_317 = 5'h1d == upd_index ? counters_29 : _GEN_316; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_318 = 5'h1e == upd_index ? counters_30 : _GEN_317; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _GEN_319 = 5'h1f == upd_index ? counters_31 : _GEN_318; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:{56,56}]
  wire [1:0] _counters_T_2 = _GEN_319 + 2'h1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:90]
  wire [1:0] _counters_T_3 = _GEN_319 == 2'h3 ? 2'h3 : _counters_T_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 96:35]
  wire [1:0] _GEN_320 = 5'h0 == upd_index ? _counters_T_3 : counters_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_321 = 5'h1 == upd_index ? _counters_T_3 : counters_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_322 = 5'h2 == upd_index ? _counters_T_3 : counters_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_323 = 5'h3 == upd_index ? _counters_T_3 : counters_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_324 = 5'h4 == upd_index ? _counters_T_3 : counters_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_325 = 5'h5 == upd_index ? _counters_T_3 : counters_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_326 = 5'h6 == upd_index ? _counters_T_3 : counters_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_327 = 5'h7 == upd_index ? _counters_T_3 : counters_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_328 = 5'h8 == upd_index ? _counters_T_3 : counters_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_329 = 5'h9 == upd_index ? _counters_T_3 : counters_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_330 = 5'ha == upd_index ? _counters_T_3 : counters_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_331 = 5'hb == upd_index ? _counters_T_3 : counters_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_332 = 5'hc == upd_index ? _counters_T_3 : counters_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_333 = 5'hd == upd_index ? _counters_T_3 : counters_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_334 = 5'he == upd_index ? _counters_T_3 : counters_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_335 = 5'hf == upd_index ? _counters_T_3 : counters_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_336 = 5'h10 == upd_index ? _counters_T_3 : counters_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_337 = 5'h11 == upd_index ? _counters_T_3 : counters_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_338 = 5'h12 == upd_index ? _counters_T_3 : counters_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_339 = 5'h13 == upd_index ? _counters_T_3 : counters_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_340 = 5'h14 == upd_index ? _counters_T_3 : counters_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_341 = 5'h15 == upd_index ? _counters_T_3 : counters_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_342 = 5'h16 == upd_index ? _counters_T_3 : counters_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_343 = 5'h17 == upd_index ? _counters_T_3 : counters_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_344 = 5'h18 == upd_index ? _counters_T_3 : counters_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_345 = 5'h19 == upd_index ? _counters_T_3 : counters_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_346 = 5'h1a == upd_index ? _counters_T_3 : counters_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_347 = 5'h1b == upd_index ? _counters_T_3 : counters_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_348 = 5'h1c == upd_index ? _counters_T_3 : counters_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_349 = 5'h1d == upd_index ? _counters_T_3 : counters_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_350 = 5'h1e == upd_index ? _counters_T_3 : counters_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_351 = 5'h1f == upd_index ? _counters_T_3 : counters_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 96:{29,29}]
  wire [1:0] _GEN_352 = 5'h0 == upd_index ? 2'h2 : counters_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_353 = 5'h1 == upd_index ? 2'h2 : counters_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_354 = 5'h2 == upd_index ? 2'h2 : counters_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_355 = 5'h3 == upd_index ? 2'h2 : counters_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_356 = 5'h4 == upd_index ? 2'h2 : counters_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_357 = 5'h5 == upd_index ? 2'h2 : counters_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_358 = 5'h6 == upd_index ? 2'h2 : counters_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_359 = 5'h7 == upd_index ? 2'h2 : counters_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_360 = 5'h8 == upd_index ? 2'h2 : counters_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_361 = 5'h9 == upd_index ? 2'h2 : counters_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_362 = 5'ha == upd_index ? 2'h2 : counters_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_363 = 5'hb == upd_index ? 2'h2 : counters_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_364 = 5'hc == upd_index ? 2'h2 : counters_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_365 = 5'hd == upd_index ? 2'h2 : counters_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_366 = 5'he == upd_index ? 2'h2 : counters_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_367 = 5'hf == upd_index ? 2'h2 : counters_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_368 = 5'h10 == upd_index ? 2'h2 : counters_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_369 = 5'h11 == upd_index ? 2'h2 : counters_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_370 = 5'h12 == upd_index ? 2'h2 : counters_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_371 = 5'h13 == upd_index ? 2'h2 : counters_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_372 = 5'h14 == upd_index ? 2'h2 : counters_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_373 = 5'h15 == upd_index ? 2'h2 : counters_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_374 = 5'h16 == upd_index ? 2'h2 : counters_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_375 = 5'h17 == upd_index ? 2'h2 : counters_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_376 = 5'h18 == upd_index ? 2'h2 : counters_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_377 = 5'h19 == upd_index ? 2'h2 : counters_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_378 = 5'h1a == upd_index ? 2'h2 : counters_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_379 = 5'h1b == upd_index ? 2'h2 : counters_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_380 = 5'h1c == upd_index ? 2'h2 : counters_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_381 = 5'h1d == upd_index ? 2'h2 : counters_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_382 = 5'h1e == upd_index ? 2'h2 : counters_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire [1:0] _GEN_383 = 5'h1f == upd_index ? 2'h2 : counters_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25 99:{29,29}]
  wire  _GEN_416 = 5'h0 == upd_index ? 1'h0 : valid_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_417 = 5'h1 == upd_index ? 1'h0 : valid_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_418 = 5'h2 == upd_index ? 1'h0 : valid_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_419 = 5'h3 == upd_index ? 1'h0 : valid_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_420 = 5'h4 == upd_index ? 1'h0 : valid_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_421 = 5'h5 == upd_index ? 1'h0 : valid_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_422 = 5'h6 == upd_index ? 1'h0 : valid_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_423 = 5'h7 == upd_index ? 1'h0 : valid_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_424 = 5'h8 == upd_index ? 1'h0 : valid_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_425 = 5'h9 == upd_index ? 1'h0 : valid_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_426 = 5'ha == upd_index ? 1'h0 : valid_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_427 = 5'hb == upd_index ? 1'h0 : valid_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_428 = 5'hc == upd_index ? 1'h0 : valid_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_429 = 5'hd == upd_index ? 1'h0 : valid_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_430 = 5'he == upd_index ? 1'h0 : valid_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_431 = 5'hf == upd_index ? 1'h0 : valid_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_432 = 5'h10 == upd_index ? 1'h0 : valid_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_433 = 5'h11 == upd_index ? 1'h0 : valid_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_434 = 5'h12 == upd_index ? 1'h0 : valid_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_435 = 5'h13 == upd_index ? 1'h0 : valid_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_436 = 5'h14 == upd_index ? 1'h0 : valid_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_437 = 5'h15 == upd_index ? 1'h0 : valid_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_438 = 5'h16 == upd_index ? 1'h0 : valid_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_439 = 5'h17 == upd_index ? 1'h0 : valid_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_440 = 5'h18 == upd_index ? 1'h0 : valid_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_441 = 5'h19 == upd_index ? 1'h0 : valid_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_442 = 5'h1a == upd_index ? 1'h0 : valid_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_443 = 5'h1b == upd_index ? 1'h0 : valid_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_444 = 5'h1c == upd_index ? 1'h0 : valid_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_445 = 5'h1d == upd_index ? 1'h0 : valid_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_446 = 5'h1e == upd_index ? 1'h0 : valid_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire  _GEN_447 = 5'h1f == upd_index ? 1'h0 : valid_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 107:{28,28} 60:24]
  wire [1:0] _counters_T_5 = _GEN_319 - 2'h1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:54]
  wire [1:0] _GEN_448 = 5'h0 == upd_index ? _counters_T_5 : counters_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_449 = 5'h1 == upd_index ? _counters_T_5 : counters_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_450 = 5'h2 == upd_index ? _counters_T_5 : counters_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_451 = 5'h3 == upd_index ? _counters_T_5 : counters_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_452 = 5'h4 == upd_index ? _counters_T_5 : counters_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_453 = 5'h5 == upd_index ? _counters_T_5 : counters_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_454 = 5'h6 == upd_index ? _counters_T_5 : counters_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_455 = 5'h7 == upd_index ? _counters_T_5 : counters_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_456 = 5'h8 == upd_index ? _counters_T_5 : counters_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_457 = 5'h9 == upd_index ? _counters_T_5 : counters_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_458 = 5'ha == upd_index ? _counters_T_5 : counters_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_459 = 5'hb == upd_index ? _counters_T_5 : counters_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_460 = 5'hc == upd_index ? _counters_T_5 : counters_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_461 = 5'hd == upd_index ? _counters_T_5 : counters_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_462 = 5'he == upd_index ? _counters_T_5 : counters_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_463 = 5'hf == upd_index ? _counters_T_5 : counters_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_464 = 5'h10 == upd_index ? _counters_T_5 : counters_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_465 = 5'h11 == upd_index ? _counters_T_5 : counters_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_466 = 5'h12 == upd_index ? _counters_T_5 : counters_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_467 = 5'h13 == upd_index ? _counters_T_5 : counters_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_468 = 5'h14 == upd_index ? _counters_T_5 : counters_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_469 = 5'h15 == upd_index ? _counters_T_5 : counters_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_470 = 5'h16 == upd_index ? _counters_T_5 : counters_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_471 = 5'h17 == upd_index ? _counters_T_5 : counters_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_472 = 5'h18 == upd_index ? _counters_T_5 : counters_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_473 = 5'h19 == upd_index ? _counters_T_5 : counters_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_474 = 5'h1a == upd_index ? _counters_T_5 : counters_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_475 = 5'h1b == upd_index ? _counters_T_5 : counters_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_476 = 5'h1c == upd_index ? _counters_T_5 : counters_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_477 = 5'h1d == upd_index ? _counters_T_5 : counters_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_478 = 5'h1e == upd_index ? _counters_T_5 : counters_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_479 = 5'h1f == upd_index ? _counters_T_5 : counters_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 109:{31,31} 66:25]
  wire [1:0] _GEN_480 = _GEN_319 > 2'h1 ? _GEN_448 : counters_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_481 = _GEN_319 > 2'h1 ? _GEN_449 : counters_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_482 = _GEN_319 > 2'h1 ? _GEN_450 : counters_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_483 = _GEN_319 > 2'h1 ? _GEN_451 : counters_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_484 = _GEN_319 > 2'h1 ? _GEN_452 : counters_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_485 = _GEN_319 > 2'h1 ? _GEN_453 : counters_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_486 = _GEN_319 > 2'h1 ? _GEN_454 : counters_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_487 = _GEN_319 > 2'h1 ? _GEN_455 : counters_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_488 = _GEN_319 > 2'h1 ? _GEN_456 : counters_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_489 = _GEN_319 > 2'h1 ? _GEN_457 : counters_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_490 = _GEN_319 > 2'h1 ? _GEN_458 : counters_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_491 = _GEN_319 > 2'h1 ? _GEN_459 : counters_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_492 = _GEN_319 > 2'h1 ? _GEN_460 : counters_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_493 = _GEN_319 > 2'h1 ? _GEN_461 : counters_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_494 = _GEN_319 > 2'h1 ? _GEN_462 : counters_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_495 = _GEN_319 > 2'h1 ? _GEN_463 : counters_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_496 = _GEN_319 > 2'h1 ? _GEN_464 : counters_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_497 = _GEN_319 > 2'h1 ? _GEN_465 : counters_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_498 = _GEN_319 > 2'h1 ? _GEN_466 : counters_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_499 = _GEN_319 > 2'h1 ? _GEN_467 : counters_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_500 = _GEN_319 > 2'h1 ? _GEN_468 : counters_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_501 = _GEN_319 > 2'h1 ? _GEN_469 : counters_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_502 = _GEN_319 > 2'h1 ? _GEN_470 : counters_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_503 = _GEN_319 > 2'h1 ? _GEN_471 : counters_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_504 = _GEN_319 > 2'h1 ? _GEN_472 : counters_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_505 = _GEN_319 > 2'h1 ? _GEN_473 : counters_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_506 = _GEN_319 > 2'h1 ? _GEN_474 : counters_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_507 = _GEN_319 > 2'h1 ? _GEN_475 : counters_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_508 = _GEN_319 > 2'h1 ? _GEN_476 : counters_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_509 = _GEN_319 > 2'h1 ? _GEN_477 : counters_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_510 = _GEN_319 > 2'h1 ? _GEN_478 : counters_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire [1:0] _GEN_511 = _GEN_319 > 2'h1 ? _GEN_479 : counters_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 108:47 66:25]
  wire  _GEN_512 = _GEN_319 == 2'h1 ? _GEN_416 : valid_0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_513 = _GEN_319 == 2'h1 ? _GEN_417 : valid_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_514 = _GEN_319 == 2'h1 ? _GEN_418 : valid_2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_515 = _GEN_319 == 2'h1 ? _GEN_419 : valid_3; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_516 = _GEN_319 == 2'h1 ? _GEN_420 : valid_4; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_517 = _GEN_319 == 2'h1 ? _GEN_421 : valid_5; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_518 = _GEN_319 == 2'h1 ? _GEN_422 : valid_6; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_519 = _GEN_319 == 2'h1 ? _GEN_423 : valid_7; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_520 = _GEN_319 == 2'h1 ? _GEN_424 : valid_8; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_521 = _GEN_319 == 2'h1 ? _GEN_425 : valid_9; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_522 = _GEN_319 == 2'h1 ? _GEN_426 : valid_10; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_523 = _GEN_319 == 2'h1 ? _GEN_427 : valid_11; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_524 = _GEN_319 == 2'h1 ? _GEN_428 : valid_12; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_525 = _GEN_319 == 2'h1 ? _GEN_429 : valid_13; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_526 = _GEN_319 == 2'h1 ? _GEN_430 : valid_14; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_527 = _GEN_319 == 2'h1 ? _GEN_431 : valid_15; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_528 = _GEN_319 == 2'h1 ? _GEN_432 : valid_16; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_529 = _GEN_319 == 2'h1 ? _GEN_433 : valid_17; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_530 = _GEN_319 == 2'h1 ? _GEN_434 : valid_18; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_531 = _GEN_319 == 2'h1 ? _GEN_435 : valid_19; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_532 = _GEN_319 == 2'h1 ? _GEN_436 : valid_20; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_533 = _GEN_319 == 2'h1 ? _GEN_437 : valid_21; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_534 = _GEN_319 == 2'h1 ? _GEN_438 : valid_22; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_535 = _GEN_319 == 2'h1 ? _GEN_439 : valid_23; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_536 = _GEN_319 == 2'h1 ? _GEN_440 : valid_24; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_537 = _GEN_319 == 2'h1 ? _GEN_441 : valid_25; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_538 = _GEN_319 == 2'h1 ? _GEN_442 : valid_26; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_539 = _GEN_319 == 2'h1 ? _GEN_443 : valid_27; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_540 = _GEN_319 == 2'h1 ? _GEN_444 : valid_28; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_541 = _GEN_319 == 2'h1 ? _GEN_445 : valid_29; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_542 = _GEN_319 == 2'h1 ? _GEN_446 : valid_30; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire  _GEN_543 = _GEN_319 == 2'h1 ? _GEN_447 : valid_31; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 60:24]
  wire [1:0] _GEN_544 = _GEN_319 == 2'h1 ? counters_0 : _GEN_480; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_545 = _GEN_319 == 2'h1 ? counters_1 : _GEN_481; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_546 = _GEN_319 == 2'h1 ? counters_2 : _GEN_482; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_547 = _GEN_319 == 2'h1 ? counters_3 : _GEN_483; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_548 = _GEN_319 == 2'h1 ? counters_4 : _GEN_484; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_549 = _GEN_319 == 2'h1 ? counters_5 : _GEN_485; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_550 = _GEN_319 == 2'h1 ? counters_6 : _GEN_486; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_551 = _GEN_319 == 2'h1 ? counters_7 : _GEN_487; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_552 = _GEN_319 == 2'h1 ? counters_8 : _GEN_488; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_553 = _GEN_319 == 2'h1 ? counters_9 : _GEN_489; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_554 = _GEN_319 == 2'h1 ? counters_10 : _GEN_490; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_555 = _GEN_319 == 2'h1 ? counters_11 : _GEN_491; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_556 = _GEN_319 == 2'h1 ? counters_12 : _GEN_492; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_557 = _GEN_319 == 2'h1 ? counters_13 : _GEN_493; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_558 = _GEN_319 == 2'h1 ? counters_14 : _GEN_494; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_559 = _GEN_319 == 2'h1 ? counters_15 : _GEN_495; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_560 = _GEN_319 == 2'h1 ? counters_16 : _GEN_496; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_561 = _GEN_319 == 2'h1 ? counters_17 : _GEN_497; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_562 = _GEN_319 == 2'h1 ? counters_18 : _GEN_498; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_563 = _GEN_319 == 2'h1 ? counters_19 : _GEN_499; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_564 = _GEN_319 == 2'h1 ? counters_20 : _GEN_500; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_565 = _GEN_319 == 2'h1 ? counters_21 : _GEN_501; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_566 = _GEN_319 == 2'h1 ? counters_22 : _GEN_502; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_567 = _GEN_319 == 2'h1 ? counters_23 : _GEN_503; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_568 = _GEN_319 == 2'h1 ? counters_24 : _GEN_504; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_569 = _GEN_319 == 2'h1 ? counters_25 : _GEN_505; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_570 = _GEN_319 == 2'h1 ? counters_26 : _GEN_506; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_571 = _GEN_319 == 2'h1 ? counters_27 : _GEN_507; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_572 = _GEN_319 == 2'h1 ? counters_28 : _GEN_508; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_573 = _GEN_319 == 2'h1 ? counters_29 : _GEN_509; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_574 = _GEN_319 == 2'h1 ? counters_30 : _GEN_510; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  wire [1:0] _GEN_575 = _GEN_319 == 2'h1 ? counters_31 : _GEN_511; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 105:43 66:25]
  assign io_predicted_pc = predict_taken ? _GEN_127 : _io_predicted_pc_T_1; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 81:25]
  assign io_predicted_taken = hit & _GEN_95 >= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 78:27]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_0 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_0 <= _GEN_192;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_0 <= _GEN_512;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_1 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_1 <= _GEN_193;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_1 <= _GEN_513;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_2 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_2 <= _GEN_194;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_2 <= _GEN_514;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_3 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_3 <= _GEN_195;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_3 <= _GEN_515;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_4 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_4 <= _GEN_196;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_4 <= _GEN_516;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_5 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_5 <= _GEN_197;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_5 <= _GEN_517;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_6 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_6 <= _GEN_198;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_6 <= _GEN_518;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_7 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_7 <= _GEN_199;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_7 <= _GEN_519;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_8 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_8 <= _GEN_200;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_8 <= _GEN_520;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_9 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_9 <= _GEN_201;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_9 <= _GEN_521;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_10 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_10 <= _GEN_202;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_10 <= _GEN_522;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_11 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_11 <= _GEN_203;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_11 <= _GEN_523;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_12 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_12 <= _GEN_204;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_12 <= _GEN_524;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_13 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_13 <= _GEN_205;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_13 <= _GEN_525;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_14 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_14 <= _GEN_206;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_14 <= _GEN_526;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_15 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_15 <= _GEN_207;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_15 <= _GEN_527;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_16 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_16 <= _GEN_208;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_16 <= _GEN_528;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_17 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_17 <= _GEN_209;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_17 <= _GEN_529;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_18 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_18 <= _GEN_210;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_18 <= _GEN_530;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_19 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_19 <= _GEN_211;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_19 <= _GEN_531;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_20 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_20 <= _GEN_212;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_20 <= _GEN_532;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_21 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_21 <= _GEN_213;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_21 <= _GEN_533;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_22 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_22 <= _GEN_214;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_22 <= _GEN_534;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_23 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_23 <= _GEN_215;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_23 <= _GEN_535;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_24 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_24 <= _GEN_216;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_24 <= _GEN_536;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_25 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_25 <= _GEN_217;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_25 <= _GEN_537;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_26 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_26 <= _GEN_218;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_26 <= _GEN_538;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_27 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_27 <= _GEN_219;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_27 <= _GEN_539;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_28 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_28 <= _GEN_220;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_28 <= _GEN_540;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_29 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_29 <= _GEN_221;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_29 <= _GEN_541;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_30 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_30 <= _GEN_222;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_30 <= _GEN_542;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
      valid_31 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 60:24]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        valid_31 <= _GEN_223;
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        valid_31 <= _GEN_543;
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h0 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_0 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_1 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h2 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_2 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h3 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_3 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h4 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_4 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h5 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_5 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h6 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_6 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h7 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_7 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h8 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_8 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h9 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_9 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'ha == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_10 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'hb == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_11 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'hc == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_12 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'hd == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_13 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'he == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_14 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'hf == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_15 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h10 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_16 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h11 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_17 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h12 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_18 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h13 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_19 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h14 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_20 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h15 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_21 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h16 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_22 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h17 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_23 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h18 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_24 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h19 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_25 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1a == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_26 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1b == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_27 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1c == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_28 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1d == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_29 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1e == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_30 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1f == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
          tags_31 <= upd_tag; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 92:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h0 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_0 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_1 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h2 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_2 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h3 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_3 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h4 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_4 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h5 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_5 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h6 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_6 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h7 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_7 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h8 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_8 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h9 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_9 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'ha == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_10 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'hb == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_11 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'hc == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_12 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'hd == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_13 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'he == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_14 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'hf == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_15 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h10 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_16 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h11 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_17 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h12 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_18 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h13 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_19 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h14 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_20 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h15 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_21 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h16 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_22 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h17 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_23 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h18 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_24 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h19 == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_25 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1a == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_26 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1b == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_27 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1c == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_28 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1d == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_29 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1e == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_30 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (5'h1f == upd_index) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
          targets_31 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 93:26]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_0 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_0 <= _GEN_320;
        end else begin
          counters_0 <= _GEN_352;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_0 <= _GEN_544;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_1 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_1 <= _GEN_321;
        end else begin
          counters_1 <= _GEN_353;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_1 <= _GEN_545;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_2 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_2 <= _GEN_322;
        end else begin
          counters_2 <= _GEN_354;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_2 <= _GEN_546;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_3 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_3 <= _GEN_323;
        end else begin
          counters_3 <= _GEN_355;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_3 <= _GEN_547;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_4 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_4 <= _GEN_324;
        end else begin
          counters_4 <= _GEN_356;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_4 <= _GEN_548;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_5 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_5 <= _GEN_325;
        end else begin
          counters_5 <= _GEN_357;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_5 <= _GEN_549;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_6 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_6 <= _GEN_326;
        end else begin
          counters_6 <= _GEN_358;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_6 <= _GEN_550;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_7 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_7 <= _GEN_327;
        end else begin
          counters_7 <= _GEN_359;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_7 <= _GEN_551;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_8 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_8 <= _GEN_328;
        end else begin
          counters_8 <= _GEN_360;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_8 <= _GEN_552;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_9 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_9 <= _GEN_329;
        end else begin
          counters_9 <= _GEN_361;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_9 <= _GEN_553;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_10 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_10 <= _GEN_330;
        end else begin
          counters_10 <= _GEN_362;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_10 <= _GEN_554;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_11 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_11 <= _GEN_331;
        end else begin
          counters_11 <= _GEN_363;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_11 <= _GEN_555;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_12 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_12 <= _GEN_332;
        end else begin
          counters_12 <= _GEN_364;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_12 <= _GEN_556;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_13 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_13 <= _GEN_333;
        end else begin
          counters_13 <= _GEN_365;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_13 <= _GEN_557;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_14 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_14 <= _GEN_334;
        end else begin
          counters_14 <= _GEN_366;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_14 <= _GEN_558;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_15 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_15 <= _GEN_335;
        end else begin
          counters_15 <= _GEN_367;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_15 <= _GEN_559;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_16 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_16 <= _GEN_336;
        end else begin
          counters_16 <= _GEN_368;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_16 <= _GEN_560;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_17 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_17 <= _GEN_337;
        end else begin
          counters_17 <= _GEN_369;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_17 <= _GEN_561;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_18 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_18 <= _GEN_338;
        end else begin
          counters_18 <= _GEN_370;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_18 <= _GEN_562;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_19 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_19 <= _GEN_339;
        end else begin
          counters_19 <= _GEN_371;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_19 <= _GEN_563;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_20 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_20 <= _GEN_340;
        end else begin
          counters_20 <= _GEN_372;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_20 <= _GEN_564;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_21 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_21 <= _GEN_341;
        end else begin
          counters_21 <= _GEN_373;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_21 <= _GEN_565;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_22 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_22 <= _GEN_342;
        end else begin
          counters_22 <= _GEN_374;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_22 <= _GEN_566;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_23 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_23 <= _GEN_343;
        end else begin
          counters_23 <= _GEN_375;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_23 <= _GEN_567;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_24 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_24 <= _GEN_344;
        end else begin
          counters_24 <= _GEN_376;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_24 <= _GEN_568;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_25 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_25 <= _GEN_345;
        end else begin
          counters_25 <= _GEN_377;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_25 <= _GEN_569;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_26 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_26 <= _GEN_346;
        end else begin
          counters_26 <= _GEN_378;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_26 <= _GEN_570;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_27 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_27 <= _GEN_347;
        end else begin
          counters_27 <= _GEN_379;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_27 <= _GEN_571;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_28 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_28 <= _GEN_348;
        end else begin
          counters_28 <= _GEN_380;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_28 <= _GEN_572;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_29 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_29 <= _GEN_349;
        end else begin
          counters_29 <= _GEN_381;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_29 <= _GEN_573;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_30 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_30 <= _GEN_350;
        end else begin
          counters_30 <= _GEN_382;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_30 <= _GEN_574;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
      counters_31 <= 2'h2; // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 66:25]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 84:25]
      if (io_update_taken) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 89:27]
        if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 95:23]
          counters_31 <= _GEN_351;
        end else begin
          counters_31 <= _GEN_383;
        end
      end else if (entry_hit) begin // @[4-soc/src/main/scala/riscv/core/BranchTargetBuffer.scala 104:23]
        counters_31 <= _GEN_575;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  valid_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  valid_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  valid_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  valid_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  valid_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  valid_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  valid_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  valid_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  valid_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  valid_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  valid_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  valid_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  valid_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  valid_13 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  valid_14 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  valid_15 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  valid_16 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  valid_17 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  valid_18 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  valid_19 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  valid_20 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  valid_21 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  valid_22 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  valid_23 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  valid_24 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  valid_25 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  valid_26 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  valid_27 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  valid_28 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  valid_29 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  valid_30 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  valid_31 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  tags_0 = _RAND_32[24:0];
  _RAND_33 = {1{`RANDOM}};
  tags_1 = _RAND_33[24:0];
  _RAND_34 = {1{`RANDOM}};
  tags_2 = _RAND_34[24:0];
  _RAND_35 = {1{`RANDOM}};
  tags_3 = _RAND_35[24:0];
  _RAND_36 = {1{`RANDOM}};
  tags_4 = _RAND_36[24:0];
  _RAND_37 = {1{`RANDOM}};
  tags_5 = _RAND_37[24:0];
  _RAND_38 = {1{`RANDOM}};
  tags_6 = _RAND_38[24:0];
  _RAND_39 = {1{`RANDOM}};
  tags_7 = _RAND_39[24:0];
  _RAND_40 = {1{`RANDOM}};
  tags_8 = _RAND_40[24:0];
  _RAND_41 = {1{`RANDOM}};
  tags_9 = _RAND_41[24:0];
  _RAND_42 = {1{`RANDOM}};
  tags_10 = _RAND_42[24:0];
  _RAND_43 = {1{`RANDOM}};
  tags_11 = _RAND_43[24:0];
  _RAND_44 = {1{`RANDOM}};
  tags_12 = _RAND_44[24:0];
  _RAND_45 = {1{`RANDOM}};
  tags_13 = _RAND_45[24:0];
  _RAND_46 = {1{`RANDOM}};
  tags_14 = _RAND_46[24:0];
  _RAND_47 = {1{`RANDOM}};
  tags_15 = _RAND_47[24:0];
  _RAND_48 = {1{`RANDOM}};
  tags_16 = _RAND_48[24:0];
  _RAND_49 = {1{`RANDOM}};
  tags_17 = _RAND_49[24:0];
  _RAND_50 = {1{`RANDOM}};
  tags_18 = _RAND_50[24:0];
  _RAND_51 = {1{`RANDOM}};
  tags_19 = _RAND_51[24:0];
  _RAND_52 = {1{`RANDOM}};
  tags_20 = _RAND_52[24:0];
  _RAND_53 = {1{`RANDOM}};
  tags_21 = _RAND_53[24:0];
  _RAND_54 = {1{`RANDOM}};
  tags_22 = _RAND_54[24:0];
  _RAND_55 = {1{`RANDOM}};
  tags_23 = _RAND_55[24:0];
  _RAND_56 = {1{`RANDOM}};
  tags_24 = _RAND_56[24:0];
  _RAND_57 = {1{`RANDOM}};
  tags_25 = _RAND_57[24:0];
  _RAND_58 = {1{`RANDOM}};
  tags_26 = _RAND_58[24:0];
  _RAND_59 = {1{`RANDOM}};
  tags_27 = _RAND_59[24:0];
  _RAND_60 = {1{`RANDOM}};
  tags_28 = _RAND_60[24:0];
  _RAND_61 = {1{`RANDOM}};
  tags_29 = _RAND_61[24:0];
  _RAND_62 = {1{`RANDOM}};
  tags_30 = _RAND_62[24:0];
  _RAND_63 = {1{`RANDOM}};
  tags_31 = _RAND_63[24:0];
  _RAND_64 = {1{`RANDOM}};
  targets_0 = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  targets_1 = _RAND_65[31:0];
  _RAND_66 = {1{`RANDOM}};
  targets_2 = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  targets_3 = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  targets_4 = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  targets_5 = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  targets_6 = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  targets_7 = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  targets_8 = _RAND_72[31:0];
  _RAND_73 = {1{`RANDOM}};
  targets_9 = _RAND_73[31:0];
  _RAND_74 = {1{`RANDOM}};
  targets_10 = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  targets_11 = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  targets_12 = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  targets_13 = _RAND_77[31:0];
  _RAND_78 = {1{`RANDOM}};
  targets_14 = _RAND_78[31:0];
  _RAND_79 = {1{`RANDOM}};
  targets_15 = _RAND_79[31:0];
  _RAND_80 = {1{`RANDOM}};
  targets_16 = _RAND_80[31:0];
  _RAND_81 = {1{`RANDOM}};
  targets_17 = _RAND_81[31:0];
  _RAND_82 = {1{`RANDOM}};
  targets_18 = _RAND_82[31:0];
  _RAND_83 = {1{`RANDOM}};
  targets_19 = _RAND_83[31:0];
  _RAND_84 = {1{`RANDOM}};
  targets_20 = _RAND_84[31:0];
  _RAND_85 = {1{`RANDOM}};
  targets_21 = _RAND_85[31:0];
  _RAND_86 = {1{`RANDOM}};
  targets_22 = _RAND_86[31:0];
  _RAND_87 = {1{`RANDOM}};
  targets_23 = _RAND_87[31:0];
  _RAND_88 = {1{`RANDOM}};
  targets_24 = _RAND_88[31:0];
  _RAND_89 = {1{`RANDOM}};
  targets_25 = _RAND_89[31:0];
  _RAND_90 = {1{`RANDOM}};
  targets_26 = _RAND_90[31:0];
  _RAND_91 = {1{`RANDOM}};
  targets_27 = _RAND_91[31:0];
  _RAND_92 = {1{`RANDOM}};
  targets_28 = _RAND_92[31:0];
  _RAND_93 = {1{`RANDOM}};
  targets_29 = _RAND_93[31:0];
  _RAND_94 = {1{`RANDOM}};
  targets_30 = _RAND_94[31:0];
  _RAND_95 = {1{`RANDOM}};
  targets_31 = _RAND_95[31:0];
  _RAND_96 = {1{`RANDOM}};
  counters_0 = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  counters_1 = _RAND_97[1:0];
  _RAND_98 = {1{`RANDOM}};
  counters_2 = _RAND_98[1:0];
  _RAND_99 = {1{`RANDOM}};
  counters_3 = _RAND_99[1:0];
  _RAND_100 = {1{`RANDOM}};
  counters_4 = _RAND_100[1:0];
  _RAND_101 = {1{`RANDOM}};
  counters_5 = _RAND_101[1:0];
  _RAND_102 = {1{`RANDOM}};
  counters_6 = _RAND_102[1:0];
  _RAND_103 = {1{`RANDOM}};
  counters_7 = _RAND_103[1:0];
  _RAND_104 = {1{`RANDOM}};
  counters_8 = _RAND_104[1:0];
  _RAND_105 = {1{`RANDOM}};
  counters_9 = _RAND_105[1:0];
  _RAND_106 = {1{`RANDOM}};
  counters_10 = _RAND_106[1:0];
  _RAND_107 = {1{`RANDOM}};
  counters_11 = _RAND_107[1:0];
  _RAND_108 = {1{`RANDOM}};
  counters_12 = _RAND_108[1:0];
  _RAND_109 = {1{`RANDOM}};
  counters_13 = _RAND_109[1:0];
  _RAND_110 = {1{`RANDOM}};
  counters_14 = _RAND_110[1:0];
  _RAND_111 = {1{`RANDOM}};
  counters_15 = _RAND_111[1:0];
  _RAND_112 = {1{`RANDOM}};
  counters_16 = _RAND_112[1:0];
  _RAND_113 = {1{`RANDOM}};
  counters_17 = _RAND_113[1:0];
  _RAND_114 = {1{`RANDOM}};
  counters_18 = _RAND_114[1:0];
  _RAND_115 = {1{`RANDOM}};
  counters_19 = _RAND_115[1:0];
  _RAND_116 = {1{`RANDOM}};
  counters_20 = _RAND_116[1:0];
  _RAND_117 = {1{`RANDOM}};
  counters_21 = _RAND_117[1:0];
  _RAND_118 = {1{`RANDOM}};
  counters_22 = _RAND_118[1:0];
  _RAND_119 = {1{`RANDOM}};
  counters_23 = _RAND_119[1:0];
  _RAND_120 = {1{`RANDOM}};
  counters_24 = _RAND_120[1:0];
  _RAND_121 = {1{`RANDOM}};
  counters_25 = _RAND_121[1:0];
  _RAND_122 = {1{`RANDOM}};
  counters_26 = _RAND_122[1:0];
  _RAND_123 = {1{`RANDOM}};
  counters_27 = _RAND_123[1:0];
  _RAND_124 = {1{`RANDOM}};
  counters_28 = _RAND_124[1:0];
  _RAND_125 = {1{`RANDOM}};
  counters_29 = _RAND_125[1:0];
  _RAND_126 = {1{`RANDOM}};
  counters_30 = _RAND_126[1:0];
  _RAND_127 = {1{`RANDOM}};
  counters_31 = _RAND_127[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ReturnAddressStack(
  input         clock,
  input         reset,
  input         io_push, // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 44:14]
  input  [31:0] io_push_addr, // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 44:14]
  input         io_pop, // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 44:14]
  output [31:0] io_predicted_addr, // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 44:14]
  output        io_valid // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 44:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] stack_0; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 64:18]
  reg [31:0] stack_1; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 64:18]
  reg [31:0] stack_2; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 64:18]
  reg [31:0] stack_3; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 64:18]
  reg [2:0] sp; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 65:22]
  wire [2:0] _tos_index_T_1 = sp - 3'h1; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 68:23]
  wire [1:0] tos_index = _tos_index_T_1[1:0]; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 68:29]
  wire  _io_valid_T = sp > 3'h0; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 71:27]
  wire [31:0] _GEN_1 = 2'h1 == tos_index ? stack_1 : stack_0; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 72:{27,27}]
  wire [31:0] _GEN_2 = 2'h2 == tos_index ? stack_2 : _GEN_1; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 72:{27,27}]
  wire [31:0] _GEN_3 = 2'h3 == tos_index ? stack_3 : _GEN_2; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 72:{27,27}]
  wire  _T = sp < 3'h4; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 77:33]
  wire [2:0] _sp_T_1 = sp + 3'h1; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 79:47]
  wire [2:0] _GEN_26 = _io_valid_T ? _tos_index_T_1 : sp; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 100:20 101:10 65:22]
  assign io_predicted_addr = io_valid ? _GEN_3 : 32'h0; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 72:27]
  assign io_valid = sp > 3'h0; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 71:27]
  always @(posedge clock) begin
    if (io_push & io_pop) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 81:33]
      if (2'h0 == tos_index) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 84:22]
        stack_0 <= io_push_addr; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 84:22]
      end
    end else if (io_push) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 85:23]
      if (_T) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 87:24]
        if (2'h0 == sp[1:0]) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 88:41]
          stack_0 <= io_push_addr; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 88:41]
        end
      end else begin
        stack_0 <= stack_1; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 93:18]
      end
    end
    if (io_push & io_pop) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 81:33]
      if (2'h1 == tos_index) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 84:22]
        stack_1 <= io_push_addr; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 84:22]
      end
    end else if (io_push) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 85:23]
      if (_T) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 87:24]
        if (2'h1 == sp[1:0]) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 88:41]
          stack_1 <= io_push_addr; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 88:41]
        end
      end else begin
        stack_1 <= stack_2; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 93:18]
      end
    end
    if (io_push & io_pop) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 81:33]
      if (2'h2 == tos_index) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 84:22]
        stack_2 <= io_push_addr; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 84:22]
      end
    end else if (io_push) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 85:23]
      if (_T) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 87:24]
        if (2'h2 == sp[1:0]) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 88:41]
          stack_2 <= io_push_addr; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 88:41]
        end
      end else begin
        stack_2 <= stack_3; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 93:18]
      end
    end
    if (io_push & io_pop) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 81:33]
      if (2'h3 == tos_index) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 84:22]
        stack_3 <= io_push_addr; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 84:22]
      end
    end else if (io_push) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 85:23]
      if (_T) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 87:24]
        if (2'h3 == sp[1:0]) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 88:41]
          stack_3 <= io_push_addr; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 88:41]
        end
      end else begin
        stack_3 <= io_push_addr; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 95:24]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 65:22]
      sp <= 3'h0; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 65:22]
    end else if (!(io_push & io_pop)) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 81:33]
      if (io_push) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 85:23]
        if (_T) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 87:24]
          sp <= _sp_T_1; // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 89:41]
        end
      end else if (io_pop) begin // @[4-soc/src/main/scala/riscv/core/ReturnAddressStack.scala 98:22]
        sp <= _GEN_26;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stack_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  stack_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  stack_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  stack_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  sp = _RAND_4[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IndirectBTB(
  input         clock,
  input         reset,
  input  [31:0] io_pc, // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 59:14]
  output [31:0] io_predicted_target, // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 59:14]
  output        io_hit, // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 59:14]
  input         io_update_valid, // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 59:14]
  input  [31:0] io_update_pc, // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 59:14]
  input  [7:0]  io_update_rs1_hash, // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 59:14]
  input  [31:0] io_update_target // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 59:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
`endif // RANDOMIZE_REG_INIT
  reg  valid_0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
  reg  valid_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
  reg  valid_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
  reg  valid_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
  reg  valid_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
  reg  valid_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
  reg  valid_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
  reg  valid_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
  reg [29:0] pc_tags_0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 78:22]
  reg [29:0] pc_tags_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 78:22]
  reg [29:0] pc_tags_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 78:22]
  reg [29:0] pc_tags_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 78:22]
  reg [29:0] pc_tags_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 78:22]
  reg [29:0] pc_tags_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 78:22]
  reg [29:0] pc_tags_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 78:22]
  reg [29:0] pc_tags_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 78:22]
  reg [7:0] rs1_hashs_0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 79:22]
  reg [7:0] rs1_hashs_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 79:22]
  reg [7:0] rs1_hashs_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 79:22]
  reg [7:0] rs1_hashs_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 79:22]
  reg [7:0] rs1_hashs_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 79:22]
  reg [7:0] rs1_hashs_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 79:22]
  reg [7:0] rs1_hashs_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 79:22]
  reg [7:0] rs1_hashs_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 79:22]
  reg [31:0] targets_0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 80:22]
  reg [31:0] targets_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 80:22]
  reg [31:0] targets_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 80:22]
  reg [31:0] targets_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 80:22]
  reg [31:0] targets_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 80:22]
  reg [31:0] targets_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 80:22]
  reg [31:0] targets_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 80:22]
  reg [31:0] targets_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 80:22]
  reg [2:0] ages_0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
  reg [2:0] ages_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
  reg [2:0] ages_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
  reg [2:0] ages_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
  reg [2:0] ages_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
  reg [2:0] ages_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
  reg [2:0] ages_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
  reg [2:0] ages_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
  wire [29:0] pred_pc_tag = io_pc[31:2]; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 84:36]
  wire  pc_hit_vec_0 = valid_0 & pc_tags_0 == pred_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 93:14]
  wire  pc_hit_vec_1 = valid_1 & pc_tags_1 == pred_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 93:14]
  wire  pc_hit_vec_2 = valid_2 & pc_tags_2 == pred_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 93:14]
  wire  pc_hit_vec_3 = valid_3 & pc_tags_3 == pred_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 93:14]
  wire  pc_hit_vec_4 = valid_4 & pc_tags_4 == pred_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 93:14]
  wire  pc_hit_vec_5 = valid_5 & pc_tags_5 == pred_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 93:14]
  wire  pc_hit_vec_6 = valid_6 & pc_tags_6 == pred_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 93:14]
  wire  pc_hit_vec_7 = valid_7 & pc_tags_7 == pred_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 93:14]
  wire [7:0] _hit_any_T = {pc_hit_vec_7,pc_hit_vec_6,pc_hit_vec_5,pc_hit_vec_4,pc_hit_vec_3,pc_hit_vec_2,pc_hit_vec_1,
    pc_hit_vec_0}; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 95:28]
  wire  hit_any = |_hit_any_T; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 95:35]
  wire [2:0] hit_ages_0 = pc_hit_vec_0 ? ages_0 : 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 100:8]
  wire [2:0] hit_ages_1 = pc_hit_vec_1 ? ages_1 : 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 100:8]
  wire [2:0] hit_ages_2 = pc_hit_vec_2 ? ages_2 : 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 100:8]
  wire [2:0] hit_ages_3 = pc_hit_vec_3 ? ages_3 : 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 100:8]
  wire [2:0] hit_ages_4 = pc_hit_vec_4 ? ages_4 : 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 100:8]
  wire [2:0] hit_ages_5 = pc_hit_vec_5 ? ages_5 : 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 100:8]
  wire [2:0] hit_ages_6 = pc_hit_vec_6 ? ages_6 : 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 100:8]
  wire [2:0] hit_ages_7 = pc_hit_vec_7 ? ages_7 : 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 100:8]
  wire [2:0] _min_age_T_1 = hit_ages_0 < hit_ages_1 ? hit_ages_0 : hit_ages_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 102:48]
  wire [2:0] _min_age_T_3 = _min_age_T_1 < hit_ages_2 ? _min_age_T_1 : hit_ages_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 102:48]
  wire [2:0] _min_age_T_5 = _min_age_T_3 < hit_ages_3 ? _min_age_T_3 : hit_ages_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 102:48]
  wire [2:0] _min_age_T_7 = _min_age_T_5 < hit_ages_4 ? _min_age_T_5 : hit_ages_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 102:48]
  wire [2:0] _min_age_T_9 = _min_age_T_7 < hit_ages_5 ? _min_age_T_7 : hit_ages_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 102:48]
  wire [2:0] _min_age_T_11 = _min_age_T_9 < hit_ages_6 ? _min_age_T_9 : hit_ages_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 102:48]
  wire [2:0] min_age = _min_age_T_11 < hit_ages_7 ? _min_age_T_11 : hit_ages_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 102:48]
  wire  mru_vec_0 = pc_hit_vec_0 & ages_0 == min_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 103:68]
  wire  mru_vec_1 = pc_hit_vec_1 & ages_1 == min_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 103:68]
  wire  mru_vec_2 = pc_hit_vec_2 & ages_2 == min_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 103:68]
  wire  mru_vec_3 = pc_hit_vec_3 & ages_3 == min_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 103:68]
  wire  mru_vec_4 = pc_hit_vec_4 & ages_4 == min_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 103:68]
  wire  mru_vec_5 = pc_hit_vec_5 & ages_5 == min_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 103:68]
  wire  mru_vec_6 = pc_hit_vec_6 & ages_6 == min_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 103:68]
  wire  mru_vec_7 = pc_hit_vec_7 & ages_7 == min_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 103:68]
  wire [7:0] _hit_index_T = {mru_vec_7,mru_vec_6,mru_vec_5,mru_vec_4,mru_vec_3,mru_vec_2,mru_vec_1,mru_vec_0}; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 104:43]
  wire [2:0] _hit_index_T_9 = _hit_index_T[6] ? 3'h6 : 3'h7; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _hit_index_T_10 = _hit_index_T[5] ? 3'h5 : _hit_index_T_9; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _hit_index_T_11 = _hit_index_T[4] ? 3'h4 : _hit_index_T_10; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _hit_index_T_12 = _hit_index_T[3] ? 3'h3 : _hit_index_T_11; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _hit_index_T_13 = _hit_index_T[2] ? 3'h2 : _hit_index_T_12; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _hit_index_T_14 = _hit_index_T[1] ? 3'h1 : _hit_index_T_13; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] hit_index = _hit_index_T[0] ? 3'h0 : _hit_index_T_14; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [31:0] _GEN_1 = 3'h1 == hit_index ? targets_1 : targets_0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 107:{29,29}]
  wire [31:0] _GEN_2 = 3'h2 == hit_index ? targets_2 : _GEN_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 107:{29,29}]
  wire [31:0] _GEN_3 = 3'h3 == hit_index ? targets_3 : _GEN_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 107:{29,29}]
  wire [31:0] _GEN_4 = 3'h4 == hit_index ? targets_4 : _GEN_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 107:{29,29}]
  wire [31:0] _GEN_5 = 3'h5 == hit_index ? targets_5 : _GEN_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 107:{29,29}]
  wire [31:0] _GEN_6 = 3'h6 == hit_index ? targets_6 : _GEN_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 107:{29,29}]
  wire [31:0] _GEN_7 = 3'h7 == hit_index ? targets_7 : _GEN_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 107:{29,29}]
  wire  _T_3 = valid_0 & ages_0 < 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:27]
  wire [2:0] _ages_0_T_1 = ages_0 + 3'h1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 117:28]
  wire [2:0] _GEN_8 = valid_0 & ages_0 < 3'h7 ? _ages_0_T_1 : ages_0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:57 117:17 81:26]
  wire [2:0] _GEN_9 = mru_vec_0 ? 3'h0 : _GEN_8; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 114:24 115:17]
  wire  _T_5 = valid_1 & ages_1 < 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:27]
  wire [2:0] _ages_1_T_1 = ages_1 + 3'h1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 117:28]
  wire [2:0] _GEN_10 = valid_1 & ages_1 < 3'h7 ? _ages_1_T_1 : ages_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:57 117:17 81:26]
  wire [2:0] _GEN_11 = mru_vec_1 ? 3'h0 : _GEN_10; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 114:24 115:17]
  wire  _T_7 = valid_2 & ages_2 < 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:27]
  wire [2:0] _ages_2_T_1 = ages_2 + 3'h1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 117:28]
  wire [2:0] _GEN_12 = valid_2 & ages_2 < 3'h7 ? _ages_2_T_1 : ages_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:57 117:17 81:26]
  wire [2:0] _GEN_13 = mru_vec_2 ? 3'h0 : _GEN_12; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 114:24 115:17]
  wire  _T_9 = valid_3 & ages_3 < 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:27]
  wire [2:0] _ages_3_T_1 = ages_3 + 3'h1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 117:28]
  wire [2:0] _GEN_14 = valid_3 & ages_3 < 3'h7 ? _ages_3_T_1 : ages_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:57 117:17 81:26]
  wire [2:0] _GEN_15 = mru_vec_3 ? 3'h0 : _GEN_14; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 114:24 115:17]
  wire  _T_11 = valid_4 & ages_4 < 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:27]
  wire [2:0] _ages_4_T_1 = ages_4 + 3'h1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 117:28]
  wire [2:0] _GEN_16 = valid_4 & ages_4 < 3'h7 ? _ages_4_T_1 : ages_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:57 117:17 81:26]
  wire [2:0] _GEN_17 = mru_vec_4 ? 3'h0 : _GEN_16; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 114:24 115:17]
  wire  _T_13 = valid_5 & ages_5 < 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:27]
  wire [2:0] _ages_5_T_1 = ages_5 + 3'h1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 117:28]
  wire [2:0] _GEN_18 = valid_5 & ages_5 < 3'h7 ? _ages_5_T_1 : ages_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:57 117:17 81:26]
  wire [2:0] _GEN_19 = mru_vec_5 ? 3'h0 : _GEN_18; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 114:24 115:17]
  wire  _T_15 = valid_6 & ages_6 < 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:27]
  wire [2:0] _ages_6_T_1 = ages_6 + 3'h1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 117:28]
  wire [2:0] _GEN_20 = valid_6 & ages_6 < 3'h7 ? _ages_6_T_1 : ages_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:57 117:17 81:26]
  wire [2:0] _GEN_21 = mru_vec_6 ? 3'h0 : _GEN_20; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 114:24 115:17]
  wire  _T_17 = valid_7 & ages_7 < 3'h7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:27]
  wire [2:0] _ages_7_T_1 = ages_7 + 3'h1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 117:28]
  wire [2:0] _GEN_22 = valid_7 & ages_7 < 3'h7 ? _ages_7_T_1 : ages_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 116:57 117:17 81:26]
  wire [2:0] _GEN_23 = mru_vec_7 ? 3'h0 : _GEN_22; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 114:24 115:17]
  wire [2:0] _GEN_24 = hit_any & ~io_update_valid ? _GEN_9 : ages_0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 111:37 81:26]
  wire [2:0] _GEN_25 = hit_any & ~io_update_valid ? _GEN_11 : ages_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 111:37 81:26]
  wire [2:0] _GEN_26 = hit_any & ~io_update_valid ? _GEN_13 : ages_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 111:37 81:26]
  wire [2:0] _GEN_27 = hit_any & ~io_update_valid ? _GEN_15 : ages_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 111:37 81:26]
  wire [2:0] _GEN_28 = hit_any & ~io_update_valid ? _GEN_17 : ages_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 111:37 81:26]
  wire [2:0] _GEN_29 = hit_any & ~io_update_valid ? _GEN_19 : ages_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 111:37 81:26]
  wire [2:0] _GEN_30 = hit_any & ~io_update_valid ? _GEN_21 : ages_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 111:37 81:26]
  wire [2:0] _GEN_31 = hit_any & ~io_update_valid ? _GEN_23 : ages_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 111:37 81:26]
  wire [29:0] upd_pc_tag = io_update_pc[31:2]; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 84:36]
  wire  existing_vec_0 = valid_0 & pc_tags_0 == upd_pc_tag & rs1_hashs_0 == io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 128:47]
  wire  existing_vec_1 = valid_1 & pc_tags_1 == upd_pc_tag & rs1_hashs_1 == io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 128:47]
  wire  existing_vec_2 = valid_2 & pc_tags_2 == upd_pc_tag & rs1_hashs_2 == io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 128:47]
  wire  existing_vec_3 = valid_3 & pc_tags_3 == upd_pc_tag & rs1_hashs_3 == io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 128:47]
  wire  existing_vec_4 = valid_4 & pc_tags_4 == upd_pc_tag & rs1_hashs_4 == io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 128:47]
  wire  existing_vec_5 = valid_5 & pc_tags_5 == upd_pc_tag & rs1_hashs_5 == io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 128:47]
  wire  existing_vec_6 = valid_6 & pc_tags_6 == upd_pc_tag & rs1_hashs_6 == io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 128:47]
  wire  existing_vec_7 = valid_7 & pc_tags_7 == upd_pc_tag & rs1_hashs_7 == io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 128:47]
  wire [7:0] _existing_any_T = {existing_vec_7,existing_vec_6,existing_vec_5,existing_vec_4,existing_vec_3,
    existing_vec_2,existing_vec_1,existing_vec_0}; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 130:39]
  wire  existing_any = |_existing_any_T; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 130:46]
  wire [2:0] _existing_index_T_9 = _existing_any_T[6] ? 3'h6 : 3'h7; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _existing_index_T_10 = _existing_any_T[5] ? 3'h5 : _existing_index_T_9; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _existing_index_T_11 = _existing_any_T[4] ? 3'h4 : _existing_index_T_10; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _existing_index_T_12 = _existing_any_T[3] ? 3'h3 : _existing_index_T_11; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _existing_index_T_13 = _existing_any_T[2] ? 3'h2 : _existing_index_T_12; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _existing_index_T_14 = _existing_any_T[1] ? 3'h1 : _existing_index_T_13; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] existing_index = _existing_any_T[0] ? 3'h0 : _existing_index_T_14; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire  invalid_vec_0 = ~valid_0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 134:60]
  wire  invalid_vec_1 = ~valid_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 134:60]
  wire  invalid_vec_2 = ~valid_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 134:60]
  wire  invalid_vec_3 = ~valid_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 134:60]
  wire  invalid_vec_4 = ~valid_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 134:60]
  wire  invalid_vec_5 = ~valid_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 134:60]
  wire  invalid_vec_6 = ~valid_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 134:60]
  wire  invalid_vec_7 = ~valid_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 134:60]
  wire [7:0] _invalid_any_T = {invalid_vec_7,invalid_vec_6,invalid_vec_5,invalid_vec_4,invalid_vec_3,invalid_vec_2,
    invalid_vec_1,invalid_vec_0}; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 135:37]
  wire  invalid_any = |_invalid_any_T; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 135:44]
  wire [2:0] _invalid_index_T_9 = _invalid_any_T[6] ? 3'h6 : 3'h7; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _invalid_index_T_10 = _invalid_any_T[5] ? 3'h5 : _invalid_index_T_9; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _invalid_index_T_11 = _invalid_any_T[4] ? 3'h4 : _invalid_index_T_10; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _invalid_index_T_12 = _invalid_any_T[3] ? 3'h3 : _invalid_index_T_11; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _invalid_index_T_13 = _invalid_any_T[2] ? 3'h2 : _invalid_index_T_12; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _invalid_index_T_14 = _invalid_any_T[1] ? 3'h1 : _invalid_index_T_13; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] invalid_index = _invalid_any_T[0] ? 3'h0 : _invalid_index_T_14; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _oldest_age_T_1 = ages_0 > ages_1 ? ages_0 : ages_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 139:49]
  wire [2:0] _oldest_age_T_3 = _oldest_age_T_1 > ages_2 ? _oldest_age_T_1 : ages_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 139:49]
  wire [2:0] _oldest_age_T_5 = _oldest_age_T_3 > ages_3 ? _oldest_age_T_3 : ages_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 139:49]
  wire [2:0] _oldest_age_T_7 = _oldest_age_T_5 > ages_4 ? _oldest_age_T_5 : ages_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 139:49]
  wire [2:0] _oldest_age_T_9 = _oldest_age_T_7 > ages_5 ? _oldest_age_T_7 : ages_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 139:49]
  wire [2:0] _oldest_age_T_11 = _oldest_age_T_9 > ages_6 ? _oldest_age_T_9 : ages_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 139:49]
  wire [2:0] oldest_age = _oldest_age_T_11 > ages_7 ? _oldest_age_T_11 : ages_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 139:49]
  wire  oldest_vec_0 = valid_0 & ages_0 == oldest_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 140:68]
  wire  oldest_vec_1 = valid_1 & ages_1 == oldest_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 140:68]
  wire  oldest_vec_2 = valid_2 & ages_2 == oldest_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 140:68]
  wire  oldest_vec_3 = valid_3 & ages_3 == oldest_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 140:68]
  wire  oldest_vec_4 = valid_4 & ages_4 == oldest_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 140:68]
  wire  oldest_vec_5 = valid_5 & ages_5 == oldest_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 140:68]
  wire  oldest_vec_6 = valid_6 & ages_6 == oldest_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 140:68]
  wire  oldest_vec_7 = valid_7 & ages_7 == oldest_age; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 140:68]
  wire [7:0] _oldest_index_T = {oldest_vec_7,oldest_vec_6,oldest_vec_5,oldest_vec_4,oldest_vec_3,oldest_vec_2,
    oldest_vec_1,oldest_vec_0}; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 141:51]
  wire [2:0] _oldest_index_T_9 = _oldest_index_T[6] ? 3'h6 : 3'h7; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _oldest_index_T_10 = _oldest_index_T[5] ? 3'h5 : _oldest_index_T_9; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _oldest_index_T_11 = _oldest_index_T[4] ? 3'h4 : _oldest_index_T_10; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _oldest_index_T_12 = _oldest_index_T[3] ? 3'h3 : _oldest_index_T_11; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _oldest_index_T_13 = _oldest_index_T[2] ? 3'h2 : _oldest_index_T_12; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _oldest_index_T_14 = _oldest_index_T[1] ? 3'h1 : _oldest_index_T_13; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] oldest_index = _oldest_index_T[0] ? 3'h0 : _oldest_index_T_14; // @[src/main/scala/chisel3/util/Mux.scala 50:70]
  wire [2:0] _target_index_T = invalid_any ? invalid_index : oldest_index; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 147:10]
  wire [2:0] target_index = existing_any ? existing_index : _target_index_T; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 144:27]
  wire  _GEN_120 = 3'h0 == target_index; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_32 = 3'h0 == target_index | valid_0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_121 = 3'h1 == target_index; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_33 = 3'h1 == target_index | valid_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_122 = 3'h2 == target_index; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_34 = 3'h2 == target_index | valid_2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_123 = 3'h3 == target_index; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_35 = 3'h3 == target_index | valid_3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_124 = 3'h4 == target_index; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_36 = 3'h4 == target_index | valid_4; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_125 = 3'h5 == target_index; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_37 = 3'h5 == target_index | valid_5; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_126 = 3'h6 == target_index; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_38 = 3'h6 == target_index | valid_6; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_127 = 3'h7 == target_index; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  wire  _GEN_39 = 3'h7 == target_index | valid_7; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 151:{29,29} 77:26]
  assign io_predicted_target = hit_any ? _GEN_7 : 32'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 107:29]
  assign io_hit = |_hit_any_T; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 95:35]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
      valid_0 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      valid_0 <= _GEN_32;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
      valid_1 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      valid_1 <= _GEN_33;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
      valid_2 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      valid_2 <= _GEN_34;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
      valid_3 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      valid_3 <= _GEN_35;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
      valid_4 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      valid_4 <= _GEN_36;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
      valid_5 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      valid_5 <= _GEN_37;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
      valid_6 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      valid_6 <= _GEN_38;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
      valid_7 <= 1'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 77:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      valid_7 <= _GEN_39;
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h0 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
        pc_tags_0 <= upd_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h1 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
        pc_tags_1 <= upd_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h2 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
        pc_tags_2 <= upd_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h3 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
        pc_tags_3 <= upd_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h4 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
        pc_tags_4 <= upd_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h5 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
        pc_tags_5 <= upd_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h6 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
        pc_tags_6 <= upd_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h7 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
        pc_tags_7 <= upd_pc_tag; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 152:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h0 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
        rs1_hashs_0 <= io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h1 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
        rs1_hashs_1 <= io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h2 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
        rs1_hashs_2 <= io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h3 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
        rs1_hashs_3 <= io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h4 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
        rs1_hashs_4 <= io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h5 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
        rs1_hashs_5 <= io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h6 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
        rs1_hashs_6 <= io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h7 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
        rs1_hashs_7 <= io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 153:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h0 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
        targets_0 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h1 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
        targets_1 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h2 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
        targets_2 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h3 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
        targets_3 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h4 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
        targets_4 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h5 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
        targets_5 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h6 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
        targets_6 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
      end
    end
    if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (3'h7 == target_index) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
        targets_7 <= io_update_target; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 154:29]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
      ages_0 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (_GEN_120) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 158:34]
        ages_0 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 159:17]
      end else if (_T_3) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 160:57]
        ages_0 <= _ages_0_T_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 161:17]
      end else begin
        ages_0 <= _GEN_24;
      end
    end else begin
      ages_0 <= _GEN_24;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
      ages_1 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (_GEN_121) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 158:34]
        ages_1 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 159:17]
      end else if (_T_5) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 160:57]
        ages_1 <= _ages_1_T_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 161:17]
      end else begin
        ages_1 <= _GEN_25;
      end
    end else begin
      ages_1 <= _GEN_25;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
      ages_2 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (_GEN_122) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 158:34]
        ages_2 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 159:17]
      end else if (_T_7) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 160:57]
        ages_2 <= _ages_2_T_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 161:17]
      end else begin
        ages_2 <= _GEN_26;
      end
    end else begin
      ages_2 <= _GEN_26;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
      ages_3 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (_GEN_123) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 158:34]
        ages_3 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 159:17]
      end else if (_T_9) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 160:57]
        ages_3 <= _ages_3_T_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 161:17]
      end else begin
        ages_3 <= _GEN_27;
      end
    end else begin
      ages_3 <= _GEN_27;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
      ages_4 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (_GEN_124) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 158:34]
        ages_4 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 159:17]
      end else if (_T_11) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 160:57]
        ages_4 <= _ages_4_T_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 161:17]
      end else begin
        ages_4 <= _GEN_28;
      end
    end else begin
      ages_4 <= _GEN_28;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
      ages_5 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (_GEN_125) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 158:34]
        ages_5 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 159:17]
      end else if (_T_13) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 160:57]
        ages_5 <= _ages_5_T_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 161:17]
      end else begin
        ages_5 <= _GEN_29;
      end
    end else begin
      ages_5 <= _GEN_29;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
      ages_6 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (_GEN_126) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 158:34]
        ages_6 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 159:17]
      end else if (_T_15) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 160:57]
        ages_6 <= _ages_6_T_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 161:17]
      end else begin
        ages_6 <= _GEN_30;
      end
    end else begin
      ages_6 <= _GEN_30;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
      ages_7 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 81:26]
    end else if (io_update_valid) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 123:25]
      if (_GEN_127) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 158:34]
        ages_7 <= 3'h0; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 159:17]
      end else if (_T_17) begin // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 160:57]
        ages_7 <= _ages_7_T_1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 161:17]
      end else begin
        ages_7 <= _GEN_31;
      end
    end else begin
      ages_7 <= _GEN_31;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  valid_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  valid_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  valid_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  valid_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  valid_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  valid_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  valid_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  valid_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  pc_tags_0 = _RAND_8[29:0];
  _RAND_9 = {1{`RANDOM}};
  pc_tags_1 = _RAND_9[29:0];
  _RAND_10 = {1{`RANDOM}};
  pc_tags_2 = _RAND_10[29:0];
  _RAND_11 = {1{`RANDOM}};
  pc_tags_3 = _RAND_11[29:0];
  _RAND_12 = {1{`RANDOM}};
  pc_tags_4 = _RAND_12[29:0];
  _RAND_13 = {1{`RANDOM}};
  pc_tags_5 = _RAND_13[29:0];
  _RAND_14 = {1{`RANDOM}};
  pc_tags_6 = _RAND_14[29:0];
  _RAND_15 = {1{`RANDOM}};
  pc_tags_7 = _RAND_15[29:0];
  _RAND_16 = {1{`RANDOM}};
  rs1_hashs_0 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  rs1_hashs_1 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  rs1_hashs_2 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  rs1_hashs_3 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  rs1_hashs_4 = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  rs1_hashs_5 = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  rs1_hashs_6 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  rs1_hashs_7 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  targets_0 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  targets_1 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  targets_2 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  targets_3 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  targets_4 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  targets_5 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  targets_6 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  targets_7 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  ages_0 = _RAND_32[2:0];
  _RAND_33 = {1{`RANDOM}};
  ages_1 = _RAND_33[2:0];
  _RAND_34 = {1{`RANDOM}};
  ages_2 = _RAND_34[2:0];
  _RAND_35 = {1{`RANDOM}};
  ages_3 = _RAND_35[2:0];
  _RAND_36 = {1{`RANDOM}};
  ages_4 = _RAND_36[2:0];
  _RAND_37 = {1{`RANDOM}};
  ages_5 = _RAND_37[2:0];
  _RAND_38 = {1{`RANDOM}};
  ages_6 = _RAND_38[2:0];
  _RAND_39 = {1{`RANDOM}};
  ages_7 = _RAND_39[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InstructionFetch(
  input         clock,
  input         reset,
  input         io_stall_flag_ctrl, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input         io_jump_flag_id, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input  [31:0] io_jump_address_id, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input  [31:0] io_rom_instruction, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input         io_instruction_valid, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input         io_btb_mispredict, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input  [31:0] io_btb_correction_addr, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input         io_btb_correct_prediction, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  output [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  output [31:0] io_id_instruction, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  output        io_btb_predicted_taken, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  output [31:0] io_btb_predicted_target, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input         io_btb_update_valid, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input  [31:0] io_btb_update_pc, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input  [31:0] io_btb_update_target, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input         io_btb_update_taken, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  output        io_ras_predicted_valid, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  output [31:0] io_ras_predicted_target, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input         io_ras_push, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input  [31:0] io_ras_push_addr, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  output        io_ibtb_predicted_valid, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  output [31:0] io_ibtb_predicted_target, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input         io_ibtb_update_valid, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input  [31:0] io_ibtb_update_pc, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input  [7:0]  io_ibtb_update_rs1_hash, // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
  input  [31:0] io_ibtb_update_target // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 67:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  btb_clock; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 119:19]
  wire  btb_reset; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 119:19]
  wire [31:0] btb_io_pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 119:19]
  wire [31:0] btb_io_predicted_pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 119:19]
  wire  btb_io_predicted_taken; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 119:19]
  wire  btb_io_update_valid; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 119:19]
  wire [31:0] btb_io_update_pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 119:19]
  wire [31:0] btb_io_update_target; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 119:19]
  wire  btb_io_update_taken; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 119:19]
  wire  ras_clock; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 128:19]
  wire  ras_reset; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 128:19]
  wire  ras_io_push; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 128:19]
  wire [31:0] ras_io_push_addr; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 128:19]
  wire  ras_io_pop; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 128:19]
  wire [31:0] ras_io_predicted_addr; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 128:19]
  wire  ras_io_valid; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 128:19]
  wire  ibtb_clock; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 132:20]
  wire  ibtb_reset; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 132:20]
  wire [31:0] ibtb_io_pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 132:20]
  wire [31:0] ibtb_io_predicted_target; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 132:20]
  wire  ibtb_io_hit; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 132:20]
  wire  ibtb_io_update_valid; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 132:20]
  wire [31:0] ibtb_io_update_pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 132:20]
  wire [7:0] ibtb_io_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 132:20]
  wire [31:0] ibtb_io_update_target; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 132:20]
  reg [31:0] pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 116:19]
  wire  is_jalr = io_rom_instruction[6:0] == 7'h67; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 138:32]
  wire [4:0] jalr_rs1 = io_rom_instruction[19:15]; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 139:25]
  wire [4:0] jalr_rd = io_rom_instruction[11:7]; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 140:25]
  wire  is_ra_or_t0 = jalr_rs1 == 5'h1 | jalr_rs1 == 5'h5; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 141:38]
  wire  is_return = is_jalr & is_ra_or_t0 & jalr_rd == 5'h0; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 142:44]
  wire  _speculative_ras_pop_T_1 = ~io_stall_flag_ctrl; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 145:66]
  wire  speculative_ras_pop = is_return & io_instruction_valid & ~io_stall_flag_ctrl; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 145:63]
  wire  is_indirect_jalr = is_jalr & ~is_return & io_instruction_valid & _speculative_ras_pop_T_1; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 161:75]
  wire  ibtb_prediction_hit = ibtb_io_hit & is_indirect_jalr; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 162:41]
  reg  pending_jump; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 172:34]
  reg [31:0] pending_jump_addr; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 173:34]
  reg  prev_jump_flag; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 181:31]
  reg [31:0] prev_jump_addr; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 182:31]
  wire  _GEN_0 = _speculative_ras_pop_T_1 ? 1'h0 : pending_jump; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 189:35 191:18 172:34]
  wire  _GEN_1 = io_stall_flag_ctrl & (io_jump_flag_id | prev_jump_flag) | _GEN_0; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 186:67 187:23]
  wire  take_pending = pending_jump & _speculative_ras_pop_T_1; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 195:35]
  wire  take_current = io_jump_flag_id & _speculative_ras_pop_T_1 & ~pending_jump & ~io_btb_correct_prediction; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 197:78]
  wire  take_btb_correction = io_btb_mispredict & _speculative_ras_pop_T_1; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 199:47]
  wire [31:0] _default_next_pc_T_1 = pc + 32'h4; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 215:51]
  wire [31:0] _default_next_pc_T_2 = btb_io_predicted_taken ? btb_io_predicted_pc : _default_next_pc_T_1; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 215:10]
  wire [31:0] _default_next_pc_T_3 = ibtb_prediction_hit ? ibtb_io_predicted_target : _default_next_pc_T_2; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 212:8]
  wire [31:0] default_next_pc = io_ras_predicted_valid ? ras_io_predicted_addr : _default_next_pc_T_3; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 209:28]
  wire  _next_pc_T_1 = io_stall_flag_ctrl | ~io_instruction_valid; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 232:27]
  wire [31:0] _next_pc_T_2 = _next_pc_T_1 ? pc : default_next_pc; // @[src/main/scala/chisel3/util/Mux.scala 141:16]
  BranchTargetBuffer btb ( // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 119:19]
    .clock(btb_clock),
    .reset(btb_reset),
    .io_pc(btb_io_pc),
    .io_predicted_pc(btb_io_predicted_pc),
    .io_predicted_taken(btb_io_predicted_taken),
    .io_update_valid(btb_io_update_valid),
    .io_update_pc(btb_io_update_pc),
    .io_update_target(btb_io_update_target),
    .io_update_taken(btb_io_update_taken)
  );
  ReturnAddressStack ras ( // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 128:19]
    .clock(ras_clock),
    .reset(ras_reset),
    .io_push(ras_io_push),
    .io_push_addr(ras_io_push_addr),
    .io_pop(ras_io_pop),
    .io_predicted_addr(ras_io_predicted_addr),
    .io_valid(ras_io_valid)
  );
  IndirectBTB ibtb ( // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 132:20]
    .clock(ibtb_clock),
    .reset(ibtb_reset),
    .io_pc(ibtb_io_pc),
    .io_predicted_target(ibtb_io_predicted_target),
    .io_hit(ibtb_io_hit),
    .io_update_valid(ibtb_io_update_valid),
    .io_update_pc(ibtb_io_update_pc),
    .io_update_rs1_hash(ibtb_io_update_rs1_hash),
    .io_update_target(ibtb_io_update_target)
  );
  assign io_instruction_address = pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 238:26]
  assign io_id_instruction = io_instruction_valid ? io_rom_instruction : 32'h13; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 239:32]
  assign io_btb_predicted_taken = btb_io_predicted_taken; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 124:27]
  assign io_btb_predicted_target = btb_io_predicted_pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 125:27]
  assign io_ras_predicted_valid = ras_io_valid & speculative_ras_pop; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 156:43]
  assign io_ras_predicted_target = ras_io_predicted_addr; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 157:27]
  assign io_ibtb_predicted_valid = ibtb_io_hit & is_indirect_jalr; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 162:41]
  assign io_ibtb_predicted_target = ibtb_io_predicted_target; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 166:28]
  assign btb_clock = clock;
  assign btb_reset = reset;
  assign btb_io_pc = pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 120:13]
  assign btb_io_update_valid = io_btb_update_valid; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 242:24]
  assign btb_io_update_pc = io_btb_update_pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 243:24]
  assign btb_io_update_target = io_btb_update_target; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 244:24]
  assign btb_io_update_taken = io_btb_update_taken; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 245:24]
  assign ras_clock = clock;
  assign ras_reset = reset;
  assign ras_io_push = io_ras_push; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 148:24]
  assign ras_io_push_addr = io_ras_push_addr; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 149:24]
  assign ras_io_pop = is_return & io_instruction_valid & ~io_stall_flag_ctrl; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 145:63]
  assign ibtb_clock = clock;
  assign ibtb_reset = reset;
  assign ibtb_io_pc = pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 133:14]
  assign ibtb_io_update_valid = io_ibtb_update_valid; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 248:27]
  assign ibtb_io_update_pc = io_ibtb_update_pc; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 249:27]
  assign ibtb_io_update_rs1_hash = io_ibtb_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 250:27]
  assign ibtb_io_update_target = io_ibtb_update_target; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 251:27]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 116:19]
      pc <= 32'h1000; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 116:19]
    end else if (take_pending) begin // @[src/main/scala/chisel3/util/Mux.scala 141:16]
      pc <= pending_jump_addr;
    end else if (take_btb_correction) begin // @[src/main/scala/chisel3/util/Mux.scala 141:16]
      pc <= io_btb_correction_addr;
    end else if (take_current) begin // @[src/main/scala/chisel3/util/Mux.scala 141:16]
      pc <= io_jump_address_id;
    end else begin
      pc <= _next_pc_T_2;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 172:34]
      pending_jump <= 1'h0; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 172:34]
    end else begin
      pending_jump <= _GEN_1;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 173:34]
      pending_jump_addr <= 32'h0; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 173:34]
    end else if (io_stall_flag_ctrl & (io_jump_flag_id | prev_jump_flag)) begin // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 186:67]
      if (io_jump_flag_id) begin // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 188:29]
        pending_jump_addr <= io_jump_address_id;
      end else begin
        pending_jump_addr <= prev_jump_addr;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 181:31]
      prev_jump_flag <= 1'h0; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 181:31]
    end else begin
      prev_jump_flag <= io_jump_flag_id; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 181:31]
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 182:31]
      prev_jump_addr <= 32'h0; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 182:31]
    end else begin
      prev_jump_addr <= io_jump_address_id; // @[4-soc/src/main/scala/riscv/core/InstructionFetch.scala 182:31]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pc = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  pending_jump = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  pending_jump_addr = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  prev_jump_flag = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  prev_jump_addr = _RAND_4[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PipelineRegister(
  input         clock,
  input         reset,
  input         io_stall, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input         io_flush, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input  [31:0] io_in, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  output [31:0] io_out // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
  assign io_out = reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 40:10]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
      reg_ <= 32'h13; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
    end else if (io_flush) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 33:18]
      reg_ <= 32'h13; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 34:9]
    end else if (~io_stall) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 35:25]
      reg_ <= io_in; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 36:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PipelineRegister_1(
  input         clock,
  input         reset,
  input         io_stall, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input         io_flush, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input  [31:0] io_in, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  output [31:0] io_out // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
  assign io_out = reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 40:10]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
      reg_ <= 32'h1000; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
    end else if (io_flush) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 33:18]
      reg_ <= 32'h1000; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 34:9]
    end else if (~io_stall) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 35:25]
      reg_ <= io_in; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 36:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PipelineRegister_2(
  input         clock,
  input         reset,
  input         io_stall, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input         io_flush, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input  [31:0] io_in, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  output [31:0] io_out // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
  assign io_out = reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 40:10]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
      reg_ <= 32'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
    end else if (io_flush) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 33:18]
      reg_ <= 32'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 34:9]
    end else if (~io_stall) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 35:25]
      reg_ <= io_in; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 36:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PipelineRegister_3(
  input   clock,
  input   reset,
  input   io_stall, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input   io_flush, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input   io_in, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  output  io_out // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
  assign io_out = reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 40:10]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
      reg_ <= 1'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
    end else if (io_flush) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 33:18]
      reg_ <= 1'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 34:9]
    end else if (~io_stall) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 35:25]
      reg_ <= io_in; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 36:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IF2ID(
  input         clock,
  input         reset,
  input         io_stall, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  input         io_flush, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  input  [31:0] io_instruction, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  input  [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  input  [31:0] io_interrupt_flag, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  input         io_btb_predicted_taken, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  input  [31:0] io_btb_predicted_target, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  input         io_ras_predicted_valid, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  input  [31:0] io_ras_predicted_target, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  input         io_ibtb_predicted_valid, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  input  [31:0] io_ibtb_predicted_target, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  output [31:0] io_output_instruction, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  output [31:0] io_output_instruction_address, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  output        io_output_btb_predicted_taken, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  output [31:0] io_output_btb_predicted_target, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  output        io_output_ras_predicted_valid, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  output [31:0] io_output_ras_predicted_target, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  output        io_output_ibtb_predicted_valid, // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
  output [31:0] io_output_ibtb_predicted_target // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 26:14]
);
  wire  instruction_clock; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 50:27]
  wire  instruction_reset; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 50:27]
  wire  instruction_io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 50:27]
  wire  instruction_io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 50:27]
  wire [31:0] instruction_io_in; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 50:27]
  wire [31:0] instruction_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 50:27]
  wire  instruction_address_clock; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 56:35]
  wire  instruction_address_reset; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 56:35]
  wire  instruction_address_io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 56:35]
  wire  instruction_address_io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 56:35]
  wire [31:0] instruction_address_io_in; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 56:35]
  wire [31:0] instruction_address_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 56:35]
  wire  interrupt_flag_clock; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 62:30]
  wire  interrupt_flag_reset; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 62:30]
  wire  interrupt_flag_io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 62:30]
  wire  interrupt_flag_io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 62:30]
  wire [31:0] interrupt_flag_io_in; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 62:30]
  wire [31:0] interrupt_flag_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 62:30]
  wire  btb_predicted_taken_clock; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 69:35]
  wire  btb_predicted_taken_reset; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 69:35]
  wire  btb_predicted_taken_io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 69:35]
  wire  btb_predicted_taken_io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 69:35]
  wire  btb_predicted_taken_io_in; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 69:35]
  wire  btb_predicted_taken_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 69:35]
  wire  btb_predicted_target_clock; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 75:36]
  wire  btb_predicted_target_reset; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 75:36]
  wire  btb_predicted_target_io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 75:36]
  wire  btb_predicted_target_io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 75:36]
  wire [31:0] btb_predicted_target_io_in; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 75:36]
  wire [31:0] btb_predicted_target_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 75:36]
  wire  ras_predicted_valid_clock; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 82:35]
  wire  ras_predicted_valid_reset; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 82:35]
  wire  ras_predicted_valid_io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 82:35]
  wire  ras_predicted_valid_io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 82:35]
  wire  ras_predicted_valid_io_in; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 82:35]
  wire  ras_predicted_valid_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 82:35]
  wire  ras_predicted_target_clock; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 88:36]
  wire  ras_predicted_target_reset; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 88:36]
  wire  ras_predicted_target_io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 88:36]
  wire  ras_predicted_target_io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 88:36]
  wire [31:0] ras_predicted_target_io_in; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 88:36]
  wire [31:0] ras_predicted_target_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 88:36]
  wire  ibtb_predicted_valid_clock; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 95:36]
  wire  ibtb_predicted_valid_reset; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 95:36]
  wire  ibtb_predicted_valid_io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 95:36]
  wire  ibtb_predicted_valid_io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 95:36]
  wire  ibtb_predicted_valid_io_in; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 95:36]
  wire  ibtb_predicted_valid_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 95:36]
  wire  ibtb_predicted_target_clock; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 101:37]
  wire  ibtb_predicted_target_reset; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 101:37]
  wire  ibtb_predicted_target_io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 101:37]
  wire  ibtb_predicted_target_io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 101:37]
  wire [31:0] ibtb_predicted_target_io_in; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 101:37]
  wire [31:0] ibtb_predicted_target_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 101:37]
  PipelineRegister instruction ( // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 50:27]
    .clock(instruction_clock),
    .reset(instruction_reset),
    .io_stall(instruction_io_stall),
    .io_flush(instruction_io_flush),
    .io_in(instruction_io_in),
    .io_out(instruction_io_out)
  );
  PipelineRegister_1 instruction_address ( // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 56:35]
    .clock(instruction_address_clock),
    .reset(instruction_address_reset),
    .io_stall(instruction_address_io_stall),
    .io_flush(instruction_address_io_flush),
    .io_in(instruction_address_io_in),
    .io_out(instruction_address_io_out)
  );
  PipelineRegister_2 interrupt_flag ( // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 62:30]
    .clock(interrupt_flag_clock),
    .reset(interrupt_flag_reset),
    .io_stall(interrupt_flag_io_stall),
    .io_flush(interrupt_flag_io_flush),
    .io_in(interrupt_flag_io_in),
    .io_out(interrupt_flag_io_out)
  );
  PipelineRegister_3 btb_predicted_taken ( // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 69:35]
    .clock(btb_predicted_taken_clock),
    .reset(btb_predicted_taken_reset),
    .io_stall(btb_predicted_taken_io_stall),
    .io_flush(btb_predicted_taken_io_flush),
    .io_in(btb_predicted_taken_io_in),
    .io_out(btb_predicted_taken_io_out)
  );
  PipelineRegister_2 btb_predicted_target ( // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 75:36]
    .clock(btb_predicted_target_clock),
    .reset(btb_predicted_target_reset),
    .io_stall(btb_predicted_target_io_stall),
    .io_flush(btb_predicted_target_io_flush),
    .io_in(btb_predicted_target_io_in),
    .io_out(btb_predicted_target_io_out)
  );
  PipelineRegister_3 ras_predicted_valid ( // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 82:35]
    .clock(ras_predicted_valid_clock),
    .reset(ras_predicted_valid_reset),
    .io_stall(ras_predicted_valid_io_stall),
    .io_flush(ras_predicted_valid_io_flush),
    .io_in(ras_predicted_valid_io_in),
    .io_out(ras_predicted_valid_io_out)
  );
  PipelineRegister_2 ras_predicted_target ( // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 88:36]
    .clock(ras_predicted_target_clock),
    .reset(ras_predicted_target_reset),
    .io_stall(ras_predicted_target_io_stall),
    .io_flush(ras_predicted_target_io_flush),
    .io_in(ras_predicted_target_io_in),
    .io_out(ras_predicted_target_io_out)
  );
  PipelineRegister_3 ibtb_predicted_valid ( // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 95:36]
    .clock(ibtb_predicted_valid_clock),
    .reset(ibtb_predicted_valid_reset),
    .io_stall(ibtb_predicted_valid_io_stall),
    .io_flush(ibtb_predicted_valid_io_flush),
    .io_in(ibtb_predicted_valid_io_in),
    .io_out(ibtb_predicted_valid_io_out)
  );
  PipelineRegister_2 ibtb_predicted_target ( // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 101:37]
    .clock(ibtb_predicted_target_clock),
    .reset(ibtb_predicted_target_reset),
    .io_stall(ibtb_predicted_target_io_stall),
    .io_flush(ibtb_predicted_target_io_flush),
    .io_in(ibtb_predicted_target_io_in),
    .io_out(ibtb_predicted_target_io_out)
  );
  assign io_output_instruction = instruction_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 54:25]
  assign io_output_instruction_address = instruction_address_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 60:33]
  assign io_output_btb_predicted_taken = btb_predicted_taken_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 73:63]
  assign io_output_btb_predicted_target = btb_predicted_target_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 79:34]
  assign io_output_ras_predicted_valid = ras_predicted_valid_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 86:63]
  assign io_output_ras_predicted_target = ras_predicted_target_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 92:34]
  assign io_output_ibtb_predicted_valid = ibtb_predicted_valid_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 99:65]
  assign io_output_ibtb_predicted_target = ibtb_predicted_target_io_out; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 105:35]
  assign instruction_clock = clock;
  assign instruction_reset = reset;
  assign instruction_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 52:25]
  assign instruction_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 53:25]
  assign instruction_io_in = io_instruction; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 51:25]
  assign instruction_address_clock = clock;
  assign instruction_address_reset = reset;
  assign instruction_address_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 58:33]
  assign instruction_address_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 59:33]
  assign instruction_address_io_in = io_instruction_address; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 57:33]
  assign interrupt_flag_clock = clock;
  assign interrupt_flag_reset = reset;
  assign interrupt_flag_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 64:28]
  assign interrupt_flag_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 65:28]
  assign interrupt_flag_io_in = io_interrupt_flag; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 63:28]
  assign btb_predicted_taken_clock = clock;
  assign btb_predicted_taken_reset = reset;
  assign btb_predicted_taken_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 71:33]
  assign btb_predicted_taken_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 72:33]
  assign btb_predicted_taken_io_in = io_btb_predicted_taken; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 70:33]
  assign btb_predicted_target_clock = clock;
  assign btb_predicted_target_reset = reset;
  assign btb_predicted_target_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 77:34]
  assign btb_predicted_target_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 78:34]
  assign btb_predicted_target_io_in = io_btb_predicted_target; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 76:34]
  assign ras_predicted_valid_clock = clock;
  assign ras_predicted_valid_reset = reset;
  assign ras_predicted_valid_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 84:33]
  assign ras_predicted_valid_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 85:33]
  assign ras_predicted_valid_io_in = io_ras_predicted_valid; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 83:33]
  assign ras_predicted_target_clock = clock;
  assign ras_predicted_target_reset = reset;
  assign ras_predicted_target_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 90:34]
  assign ras_predicted_target_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 91:34]
  assign ras_predicted_target_io_in = io_ras_predicted_target; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 89:34]
  assign ibtb_predicted_valid_clock = clock;
  assign ibtb_predicted_valid_reset = reset;
  assign ibtb_predicted_valid_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 97:34]
  assign ibtb_predicted_valid_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 98:34]
  assign ibtb_predicted_valid_io_in = io_ibtb_predicted_valid; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 96:34]
  assign ibtb_predicted_target_clock = clock;
  assign ibtb_predicted_target_reset = reset;
  assign ibtb_predicted_target_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 103:35]
  assign ibtb_predicted_target_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 104:35]
  assign ibtb_predicted_target_io_in = io_ibtb_predicted_target; // @[4-soc/src/main/scala/riscv/core/IF2ID.scala 102:35]
endmodule
module InstructionDecode(
  input  [31:0] io_instruction, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  input  [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  input  [31:0] io_reg1_data, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  input  [31:0] io_reg2_data, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  input  [31:0] io_forward_from_mem, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  input  [31:0] io_forward_from_wb, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  input  [1:0]  io_reg1_forward, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  input  [1:0]  io_reg2_forward, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  input         io_interrupt_assert, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  input  [31:0] io_interrupt_handler_address, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  input         io_branch_hazard, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output [4:0]  io_regs_reg1_read_address, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output [4:0]  io_regs_reg2_read_address, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output [31:0] io_ex_immediate, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output        io_ex_aluop1_source, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output        io_ex_aluop2_source, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output        io_ex_memory_read_enable, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output        io_ex_memory_write_enable, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output [1:0]  io_ex_reg_write_source, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output        io_ex_reg_write_enable, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output [4:0]  io_ex_reg_write_address, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output [11:0] io_ex_csr_address, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output        io_ex_csr_write_enable, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output        io_ctrl_jump_instruction, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output        io_clint_jump_flag, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output [31:0] io_clint_jump_address, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output        io_if_jump_flag, // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
  output [31:0] io_if_jump_address // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 12:14]
);
  wire [6:0] opcode = io_instruction[6:0]; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 45:30]
  wire [2:0] funct3 = io_instruction[14:12]; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 46:30]
  wire [4:0] rs1 = io_instruction[19:15]; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 49:30]
  wire [4:0] rs2 = io_instruction[24:20]; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 50:30]
  wire  _csr_uses_uimm_T = opcode == 7'h73; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 54:30]
  wire  _csr_uses_uimm_T_1 = funct3 == 3'h5; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 55:12]
  wire  _csr_uses_uimm_T_2 = funct3 == 3'h7; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 56:14]
  wire  _csr_uses_uimm_T_3 = funct3 == 3'h5 | _csr_uses_uimm_T_2; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 55:43]
  wire  _csr_uses_uimm_T_4 = funct3 == 3'h6; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 57:14]
  wire  _csr_uses_uimm_T_5 = _csr_uses_uimm_T_3 | _csr_uses_uimm_T_4; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 56:45]
  wire  csr_uses_uimm = opcode == 7'h73 & _csr_uses_uimm_T_5; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 54:51]
  wire  _uses_rs1_T = opcode == 7'h33; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 59:26]
  wire  _uses_rs1_T_3 = opcode == 7'h3; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 60:13]
  wire  _uses_rs1_T_4 = opcode == 7'h33 | opcode == 7'h13 | _uses_rs1_T_3; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 59:86]
  wire  _uses_rs1_T_5 = opcode == 7'h23; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 60:48]
  wire  _uses_rs1_T_7 = opcode == 7'h63; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 60:83]
  wire  _uses_rs1_T_9 = opcode == 7'h67; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 61:13]
  wire  _uses_rs1_T_10 = _uses_rs1_T_4 | opcode == 7'h23 | opcode == 7'h63 | _uses_rs1_T_9; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 60:107]
  wire  uses_rs1 = _uses_rs1_T_10 | _csr_uses_uimm_T & ~csr_uses_uimm; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 61:36]
  wire  uses_rs2 = _uses_rs1_T | _uses_rs1_T_5 | _uses_rs1_T_7; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 62:86]
  wire [19:0] _io_ex_immediate_T_1 = io_instruction[31] ? 20'hfffff : 20'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 68:13]
  wire [31:0] _io_ex_immediate_T_3 = {_io_ex_immediate_T_1,io_instruction[31:20]}; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 68:8]
  wire [20:0] _io_ex_immediate_T_5 = io_instruction[31] ? 21'h1fffff : 21'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 71:37]
  wire [31:0] _io_ex_immediate_T_7 = {_io_ex_immediate_T_5,io_instruction[30:20]}; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 71:32]
  wire [31:0] _io_ex_immediate_T_20 = {_io_ex_immediate_T_5,io_instruction[30:25],io_instruction[11:7]}; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 74:32]
  wire [31:0] _io_ex_immediate_T_26 = {_io_ex_immediate_T_1,io_instruction[7],io_instruction[30:25],io_instruction[11:8]
    ,1'h0}; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 75:32]
  wire [31:0] _io_ex_immediate_T_28 = {io_instruction[31:12],12'h0}; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 82:32]
  wire [11:0] _io_ex_immediate_T_32 = io_instruction[31] ? 12'hfff : 12'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 85:13]
  wire [31:0] _io_ex_immediate_T_36 = {_io_ex_immediate_T_32,io_instruction[19:12],io_instruction[20],io_instruction[30:
    21],1'h0}; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 84:30]
  wire [31:0] _io_ex_immediate_T_38 = 7'h13 == opcode ? _io_ex_immediate_T_7 : _io_ex_immediate_T_3; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire  _io_ex_immediate_T_39 = 7'h3 == opcode; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire [31:0] _io_ex_immediate_T_40 = 7'h3 == opcode ? _io_ex_immediate_T_7 : _io_ex_immediate_T_38; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire  _io_ex_immediate_T_41 = 7'h67 == opcode; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire [31:0] _io_ex_immediate_T_42 = 7'h67 == opcode ? _io_ex_immediate_T_7 : _io_ex_immediate_T_40; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire [31:0] _io_ex_immediate_T_44 = 7'h23 == opcode ? _io_ex_immediate_T_20 : _io_ex_immediate_T_42; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire  _io_ex_immediate_T_45 = 7'h63 == opcode; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire [31:0] _io_ex_immediate_T_46 = 7'h63 == opcode ? _io_ex_immediate_T_26 : _io_ex_immediate_T_44; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire [31:0] _io_ex_immediate_T_48 = 7'h37 == opcode ? _io_ex_immediate_T_28 : _io_ex_immediate_T_46; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire [31:0] _io_ex_immediate_T_50 = 7'h17 == opcode ? _io_ex_immediate_T_28 : _io_ex_immediate_T_48; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire  _io_ex_immediate_T_51 = 7'h6f == opcode; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  wire  _io_ex_aluop1_source_T = opcode == 7'h17; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 94:12]
  wire  _io_ex_aluop1_source_T_3 = opcode == 7'h6f; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 94:78]
  wire [1:0] _io_ex_reg_write_source_T_1 = _io_ex_immediate_T_39 ? 2'h1 : 2'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 108:4]
  wire [1:0] _io_ex_reg_write_source_T_3 = 7'h73 == opcode ? 2'h2 : _io_ex_reg_write_source_T_1; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 108:4]
  wire [1:0] _io_ex_reg_write_source_T_5 = _io_ex_immediate_T_51 ? 2'h3 : _io_ex_reg_write_source_T_3; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 108:4]
  wire  _io_ex_reg_write_enable_T_10 = _uses_rs1_T_4 | _io_ex_aluop1_source_T | opcode == 7'h37 |
    _io_ex_aluop1_source_T_3; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 117:105]
  wire  _io_ex_csr_write_enable_T_4 = funct3 == 3'h2; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 123:14]
  wire  _io_ex_csr_write_enable_T_5 = funct3 == 3'h1 | _csr_uses_uimm_T_1 | _io_ex_csr_write_enable_T_4; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 122:83]
  wire  _io_ex_csr_write_enable_T_8 = funct3 == 3'h3; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 124:14]
  wire  _io_ex_csr_write_enable_T_9 = _io_ex_csr_write_enable_T_5 | _csr_uses_uimm_T_4 | _io_ex_csr_write_enable_T_8; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 123:85]
  wire  _io_ex_csr_write_enable_T_11 = _io_ex_csr_write_enable_T_9 | _csr_uses_uimm_T_2; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 124:44]
  wire [31:0] _reg1_data_forwarded_T_1 = 2'h0 == io_reg1_forward ? io_reg1_data : 32'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 129:60]
  wire [31:0] _reg1_data_forwarded_T_3 = 2'h2 == io_reg1_forward ? io_forward_from_wb : _reg1_data_forwarded_T_1; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 129:60]
  wire [31:0] reg1_data_forwarded = 2'h1 == io_reg1_forward ? io_forward_from_mem : _reg1_data_forwarded_T_3; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 129:60]
  wire [31:0] _reg2_data_forwarded_T_1 = 2'h0 == io_reg2_forward ? io_reg2_data : 32'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 136:60]
  wire [31:0] _reg2_data_forwarded_T_3 = 2'h2 == io_reg2_forward ? io_forward_from_wb : _reg2_data_forwarded_T_1; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 136:60]
  wire [31:0] reg2_data_forwarded = 2'h1 == io_reg2_forward ? io_forward_from_mem : _reg2_data_forwarded_T_3; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 136:60]
  wire [31:0] reg1_data = uses_rs1 ? reg1_data_forwarded : 32'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 143:22]
  wire [31:0] reg2_data = uses_rs2 ? reg2_data_forwarded : 32'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 144:22]
  wire  _io_ctrl_jump_instruction_T_2 = _io_ex_aluop1_source_T_3 | _uses_rs1_T_9; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 145:59]
  wire  _branch_taken_T_5 = reg1_data == reg2_data; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 162:48]
  wire  _branch_taken_T_6 = reg1_data != reg2_data; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 163:48]
  wire [31:0] _branch_taken_T_7 = uses_rs1 ? reg1_data_forwarded : 32'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 164:48]
  wire [31:0] _branch_taken_T_8 = uses_rs2 ? reg2_data_forwarded : 32'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 164:67]
  wire  _branch_taken_T_9 = $signed(_branch_taken_T_7) < $signed(_branch_taken_T_8); // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 164:55]
  wire  _branch_taken_T_12 = $signed(_branch_taken_T_7) >= $signed(_branch_taken_T_8); // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 165:55]
  wire  _branch_taken_T_13 = reg1_data < reg2_data; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 166:55]
  wire  _branch_taken_T_14 = reg1_data >= reg2_data; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 167:55]
  wire  _branch_taken_T_18 = 3'h1 == funct3 ? _branch_taken_T_6 : 3'h0 == funct3 & _branch_taken_T_5; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 160:8]
  wire  _branch_taken_T_20 = 3'h4 == funct3 ? _branch_taken_T_9 : _branch_taken_T_18; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 160:8]
  wire  _branch_taken_T_22 = 3'h5 == funct3 ? _branch_taken_T_12 : _branch_taken_T_20; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 160:8]
  wire  _branch_taken_T_24 = 3'h6 == funct3 ? _branch_taken_T_13 : _branch_taken_T_22; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 160:8]
  wire  _branch_taken_T_26 = 3'h7 == funct3 ? _branch_taken_T_14 : _branch_taken_T_24; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 160:8]
  wire  _branch_taken_T_27 = _uses_rs1_T_7 & _branch_taken_T_26; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 157:39]
  wire  _branch_taken_T_28 = _io_ctrl_jump_instruction_T_2 | _branch_taken_T_27; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 156:38]
  wire  branch_taken = ~io_branch_hazard & _branch_taken_T_28; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 154:40]
  wire [31:0] _jalr_target_T_1 = reg1_data + io_ex_immediate; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 174:36]
  wire [31:0] jalr_target = {_jalr_target_T_1[31:1],1'h0}; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 174:24]
  wire [31:0] _io_if_jump_address_T_1 = io_instruction_address + io_ex_immediate; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 181:55]
  wire [31:0] _io_if_jump_address_T_5 = _io_ex_immediate_T_45 ? _io_if_jump_address_T_1 : 32'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 179:27]
  wire [31:0] _io_if_jump_address_T_7 = _io_ex_immediate_T_51 ? _io_if_jump_address_T_1 : _io_if_jump_address_T_5; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 179:27]
  wire [31:0] _io_if_jump_address_T_9 = _io_ex_immediate_T_41 ? jalr_target : _io_if_jump_address_T_7; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 179:27]
  assign io_regs_reg1_read_address = uses_rs1 ? rs1 : 5'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 64:35]
  assign io_regs_reg2_read_address = uses_rs2 ? rs2 : 5'h0; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 65:35]
  assign io_ex_immediate = 7'h6f == opcode ? _io_ex_immediate_T_36 : _io_ex_immediate_T_50; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 69:4]
  assign io_ex_aluop1_source = opcode == 7'h17 | _uses_rs1_T_7 | opcode == 7'h6f; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 94:68]
  assign io_ex_aluop2_source = _uses_rs1_T ? 1'h0 : 1'h1; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 98:29]
  assign io_ex_memory_read_enable = opcode == 7'h3; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 103:39]
  assign io_ex_memory_write_enable = opcode == 7'h23; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 104:39]
  assign io_ex_reg_write_source = _io_ex_immediate_T_41 ? 2'h3 : _io_ex_reg_write_source_T_5; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 108:4]
  assign io_ex_reg_write_enable = _io_ex_reg_write_enable_T_10 | _uses_rs1_T_9 | _csr_uses_uimm_T; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 118:69]
  assign io_ex_reg_write_address = io_instruction[11:7]; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 119:44]
  assign io_ex_csr_address = io_instruction[31:20]; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 120:44]
  assign io_ex_csr_write_enable = _csr_uses_uimm_T & _io_ex_csr_write_enable_T_11; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 121:59]
  assign io_ctrl_jump_instruction = _io_ctrl_jump_instruction_T_2 | _uses_rs1_T_7; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 146:36]
  assign io_clint_jump_flag = io_ctrl_jump_instruction; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 187:22]
  assign io_clint_jump_address = _io_ex_immediate_T_41 ? jalr_target : _io_if_jump_address_T_7; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 191:4]
  assign io_if_jump_flag = branch_taken | io_interrupt_assert; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 172:35]
  assign io_if_jump_address = io_interrupt_assert ? io_interrupt_handler_address : _io_if_jump_address_T_9; // @[4-soc/src/main/scala/riscv/core/InstructionDecode.scala 176:28]
endmodule
module PipelineRegister_11(
  input        clock,
  input        reset,
  input        io_stall, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input        io_flush, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input  [4:0] io_in, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  output [4:0] io_out // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
  assign io_out = reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 40:10]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
      reg_ <= 5'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
    end else if (io_flush) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 33:18]
      reg_ <= 5'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 34:9]
    end else if (~io_stall) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 35:25]
      reg_ <= io_in; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 36:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PipelineRegister_15(
  input        clock,
  input        reset,
  input        io_stall, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input        io_flush, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input  [1:0] io_in, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  output [1:0] io_out // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
  assign io_out = reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 40:10]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
      reg_ <= 2'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
    end else if (io_flush) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 33:18]
      reg_ <= 2'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 34:9]
    end else if (~io_stall) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 35:25]
      reg_ <= io_in; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 36:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PipelineRegister_22(
  input         clock,
  input         reset,
  input         io_stall, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input         io_flush, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input  [11:0] io_in, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  output [11:0] io_out // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [11:0] reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
  assign io_out = reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 40:10]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
      reg_ <= 12'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
    end else if (io_flush) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 33:18]
      reg_ <= 12'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 34:9]
    end else if (~io_stall) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 35:25]
      reg_ <= io_in; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 36:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ID2EX(
  input         clock,
  input         reset,
  input         io_stall, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input         io_flush, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [31:0] io_instruction, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [4:0]  io_regs_reg1_read_address, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [4:0]  io_regs_reg2_read_address, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input         io_regs_write_enable, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [4:0]  io_regs_write_address, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [1:0]  io_regs_write_source, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [31:0] io_reg1_data, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [31:0] io_reg2_data, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [31:0] io_immediate, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input         io_aluop1_source, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input         io_aluop2_source, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input         io_csr_write_enable, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [11:0] io_csr_address, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input         io_memory_read_enable, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input         io_memory_write_enable, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  input  [31:0] io_csr_read_data, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [31:0] io_output_instruction, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [31:0] io_output_instruction_address, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [4:0]  io_output_regs_reg1_read_address, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [4:0]  io_output_regs_reg2_read_address, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output        io_output_regs_write_enable, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [4:0]  io_output_regs_write_address, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [1:0]  io_output_regs_write_source, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [31:0] io_output_reg1_data, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [31:0] io_output_reg2_data, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [31:0] io_output_immediate, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output        io_output_aluop1_source, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output        io_output_aluop2_source, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output        io_output_csr_write_enable, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [11:0] io_output_csr_address, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output        io_output_memory_read_enable, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output        io_output_memory_write_enable, // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
  output [31:0] io_output_csr_read_data // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 30:14]
);
  wire  instruction_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 71:27]
  wire  instruction_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 71:27]
  wire  instruction_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 71:27]
  wire  instruction_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 71:27]
  wire [31:0] instruction_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 71:27]
  wire [31:0] instruction_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 71:27]
  wire  instruction_address_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 77:35]
  wire  instruction_address_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 77:35]
  wire  instruction_address_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 77:35]
  wire  instruction_address_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 77:35]
  wire [31:0] instruction_address_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 77:35]
  wire [31:0] instruction_address_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 77:35]
  wire  regs_reg1_read_address_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 83:38]
  wire  regs_reg1_read_address_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 83:38]
  wire  regs_reg1_read_address_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 83:38]
  wire  regs_reg1_read_address_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 83:38]
  wire [4:0] regs_reg1_read_address_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 83:38]
  wire [4:0] regs_reg1_read_address_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 83:38]
  wire  regs_reg2_read_address_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 89:38]
  wire  regs_reg2_read_address_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 89:38]
  wire  regs_reg2_read_address_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 89:38]
  wire  regs_reg2_read_address_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 89:38]
  wire [4:0] regs_reg2_read_address_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 89:38]
  wire [4:0] regs_reg2_read_address_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 89:38]
  wire  regs_write_enable_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 95:33]
  wire  regs_write_enable_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 95:33]
  wire  regs_write_enable_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 95:33]
  wire  regs_write_enable_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 95:33]
  wire  regs_write_enable_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 95:33]
  wire  regs_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 95:33]
  wire  regs_write_address_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 101:34]
  wire  regs_write_address_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 101:34]
  wire  regs_write_address_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 101:34]
  wire  regs_write_address_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 101:34]
  wire [4:0] regs_write_address_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 101:34]
  wire [4:0] regs_write_address_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 101:34]
  wire  regs_write_source_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 107:33]
  wire  regs_write_source_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 107:33]
  wire  regs_write_source_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 107:33]
  wire  regs_write_source_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 107:33]
  wire [1:0] regs_write_source_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 107:33]
  wire [1:0] regs_write_source_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 107:33]
  wire  reg1_data_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 113:25]
  wire  reg1_data_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 113:25]
  wire  reg1_data_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 113:25]
  wire  reg1_data_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 113:25]
  wire [31:0] reg1_data_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 113:25]
  wire [31:0] reg1_data_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 113:25]
  wire  reg2_data_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 119:25]
  wire  reg2_data_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 119:25]
  wire  reg2_data_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 119:25]
  wire  reg2_data_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 119:25]
  wire [31:0] reg2_data_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 119:25]
  wire [31:0] reg2_data_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 119:25]
  wire  immediate_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 125:25]
  wire  immediate_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 125:25]
  wire  immediate_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 125:25]
  wire  immediate_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 125:25]
  wire [31:0] immediate_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 125:25]
  wire [31:0] immediate_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 125:25]
  wire  aluop1_source_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 131:29]
  wire  aluop1_source_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 131:29]
  wire  aluop1_source_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 131:29]
  wire  aluop1_source_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 131:29]
  wire  aluop1_source_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 131:29]
  wire  aluop1_source_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 131:29]
  wire  aluop2_source_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 137:29]
  wire  aluop2_source_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 137:29]
  wire  aluop2_source_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 137:29]
  wire  aluop2_source_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 137:29]
  wire  aluop2_source_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 137:29]
  wire  aluop2_source_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 137:29]
  wire  csr_write_enable_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 143:32]
  wire  csr_write_enable_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 143:32]
  wire  csr_write_enable_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 143:32]
  wire  csr_write_enable_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 143:32]
  wire  csr_write_enable_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 143:32]
  wire  csr_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 143:32]
  wire  csr_address_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 149:27]
  wire  csr_address_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 149:27]
  wire  csr_address_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 149:27]
  wire  csr_address_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 149:27]
  wire [11:0] csr_address_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 149:27]
  wire [11:0] csr_address_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 149:27]
  wire  memory_read_enable_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 155:34]
  wire  memory_read_enable_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 155:34]
  wire  memory_read_enable_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 155:34]
  wire  memory_read_enable_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 155:34]
  wire  memory_read_enable_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 155:34]
  wire  memory_read_enable_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 155:34]
  wire  memory_write_enable_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 161:35]
  wire  memory_write_enable_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 161:35]
  wire  memory_write_enable_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 161:35]
  wire  memory_write_enable_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 161:35]
  wire  memory_write_enable_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 161:35]
  wire  memory_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 161:35]
  wire  csr_read_data_clock; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 167:29]
  wire  csr_read_data_reset; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 167:29]
  wire  csr_read_data_io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 167:29]
  wire  csr_read_data_io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 167:29]
  wire [31:0] csr_read_data_io_in; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 167:29]
  wire [31:0] csr_read_data_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 167:29]
  PipelineRegister instruction ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 71:27]
    .clock(instruction_clock),
    .reset(instruction_reset),
    .io_stall(instruction_io_stall),
    .io_flush(instruction_io_flush),
    .io_in(instruction_io_in),
    .io_out(instruction_io_out)
  );
  PipelineRegister_1 instruction_address ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 77:35]
    .clock(instruction_address_clock),
    .reset(instruction_address_reset),
    .io_stall(instruction_address_io_stall),
    .io_flush(instruction_address_io_flush),
    .io_in(instruction_address_io_in),
    .io_out(instruction_address_io_out)
  );
  PipelineRegister_11 regs_reg1_read_address ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 83:38]
    .clock(regs_reg1_read_address_clock),
    .reset(regs_reg1_read_address_reset),
    .io_stall(regs_reg1_read_address_io_stall),
    .io_flush(regs_reg1_read_address_io_flush),
    .io_in(regs_reg1_read_address_io_in),
    .io_out(regs_reg1_read_address_io_out)
  );
  PipelineRegister_11 regs_reg2_read_address ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 89:38]
    .clock(regs_reg2_read_address_clock),
    .reset(regs_reg2_read_address_reset),
    .io_stall(regs_reg2_read_address_io_stall),
    .io_flush(regs_reg2_read_address_io_flush),
    .io_in(regs_reg2_read_address_io_in),
    .io_out(regs_reg2_read_address_io_out)
  );
  PipelineRegister_3 regs_write_enable ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 95:33]
    .clock(regs_write_enable_clock),
    .reset(regs_write_enable_reset),
    .io_stall(regs_write_enable_io_stall),
    .io_flush(regs_write_enable_io_flush),
    .io_in(regs_write_enable_io_in),
    .io_out(regs_write_enable_io_out)
  );
  PipelineRegister_11 regs_write_address ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 101:34]
    .clock(regs_write_address_clock),
    .reset(regs_write_address_reset),
    .io_stall(regs_write_address_io_stall),
    .io_flush(regs_write_address_io_flush),
    .io_in(regs_write_address_io_in),
    .io_out(regs_write_address_io_out)
  );
  PipelineRegister_15 regs_write_source ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 107:33]
    .clock(regs_write_source_clock),
    .reset(regs_write_source_reset),
    .io_stall(regs_write_source_io_stall),
    .io_flush(regs_write_source_io_flush),
    .io_in(regs_write_source_io_in),
    .io_out(regs_write_source_io_out)
  );
  PipelineRegister_2 reg1_data ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 113:25]
    .clock(reg1_data_clock),
    .reset(reg1_data_reset),
    .io_stall(reg1_data_io_stall),
    .io_flush(reg1_data_io_flush),
    .io_in(reg1_data_io_in),
    .io_out(reg1_data_io_out)
  );
  PipelineRegister_2 reg2_data ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 119:25]
    .clock(reg2_data_clock),
    .reset(reg2_data_reset),
    .io_stall(reg2_data_io_stall),
    .io_flush(reg2_data_io_flush),
    .io_in(reg2_data_io_in),
    .io_out(reg2_data_io_out)
  );
  PipelineRegister_2 immediate ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 125:25]
    .clock(immediate_clock),
    .reset(immediate_reset),
    .io_stall(immediate_io_stall),
    .io_flush(immediate_io_flush),
    .io_in(immediate_io_in),
    .io_out(immediate_io_out)
  );
  PipelineRegister_3 aluop1_source ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 131:29]
    .clock(aluop1_source_clock),
    .reset(aluop1_source_reset),
    .io_stall(aluop1_source_io_stall),
    .io_flush(aluop1_source_io_flush),
    .io_in(aluop1_source_io_in),
    .io_out(aluop1_source_io_out)
  );
  PipelineRegister_3 aluop2_source ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 137:29]
    .clock(aluop2_source_clock),
    .reset(aluop2_source_reset),
    .io_stall(aluop2_source_io_stall),
    .io_flush(aluop2_source_io_flush),
    .io_in(aluop2_source_io_in),
    .io_out(aluop2_source_io_out)
  );
  PipelineRegister_3 csr_write_enable ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 143:32]
    .clock(csr_write_enable_clock),
    .reset(csr_write_enable_reset),
    .io_stall(csr_write_enable_io_stall),
    .io_flush(csr_write_enable_io_flush),
    .io_in(csr_write_enable_io_in),
    .io_out(csr_write_enable_io_out)
  );
  PipelineRegister_22 csr_address ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 149:27]
    .clock(csr_address_clock),
    .reset(csr_address_reset),
    .io_stall(csr_address_io_stall),
    .io_flush(csr_address_io_flush),
    .io_in(csr_address_io_in),
    .io_out(csr_address_io_out)
  );
  PipelineRegister_3 memory_read_enable ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 155:34]
    .clock(memory_read_enable_clock),
    .reset(memory_read_enable_reset),
    .io_stall(memory_read_enable_io_stall),
    .io_flush(memory_read_enable_io_flush),
    .io_in(memory_read_enable_io_in),
    .io_out(memory_read_enable_io_out)
  );
  PipelineRegister_3 memory_write_enable ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 161:35]
    .clock(memory_write_enable_clock),
    .reset(memory_write_enable_reset),
    .io_stall(memory_write_enable_io_stall),
    .io_flush(memory_write_enable_io_flush),
    .io_in(memory_write_enable_io_in),
    .io_out(memory_write_enable_io_out)
  );
  PipelineRegister_2 csr_read_data ( // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 167:29]
    .clock(csr_read_data_clock),
    .reset(csr_read_data_reset),
    .io_stall(csr_read_data_io_stall),
    .io_flush(csr_read_data_io_flush),
    .io_in(csr_read_data_io_in),
    .io_out(csr_read_data_io_out)
  );
  assign io_output_instruction = instruction_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 75:25]
  assign io_output_instruction_address = instruction_address_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 81:33]
  assign io_output_regs_reg1_read_address = regs_reg1_read_address_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 87:36]
  assign io_output_regs_reg2_read_address = regs_reg2_read_address_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 93:36]
  assign io_output_regs_write_enable = regs_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 99:31]
  assign io_output_regs_write_address = regs_write_address_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 105:32]
  assign io_output_regs_write_source = regs_write_source_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 111:31]
  assign io_output_reg1_data = reg1_data_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 117:23]
  assign io_output_reg2_data = reg2_data_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 123:23]
  assign io_output_immediate = immediate_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 129:23]
  assign io_output_aluop1_source = aluop1_source_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 135:27]
  assign io_output_aluop2_source = aluop2_source_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 141:27]
  assign io_output_csr_write_enable = csr_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 147:30]
  assign io_output_csr_address = csr_address_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 153:25]
  assign io_output_memory_read_enable = memory_read_enable_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 159:32]
  assign io_output_memory_write_enable = memory_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 165:33]
  assign io_output_csr_read_data = csr_read_data_io_out; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 171:27]
  assign instruction_clock = clock;
  assign instruction_reset = reset;
  assign instruction_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 73:25]
  assign instruction_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 74:25]
  assign instruction_io_in = io_instruction; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 72:25]
  assign instruction_address_clock = clock;
  assign instruction_address_reset = reset;
  assign instruction_address_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 79:33]
  assign instruction_address_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 80:33]
  assign instruction_address_io_in = io_instruction_address; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 78:33]
  assign regs_reg1_read_address_clock = clock;
  assign regs_reg1_read_address_reset = reset;
  assign regs_reg1_read_address_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 85:36]
  assign regs_reg1_read_address_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 86:36]
  assign regs_reg1_read_address_io_in = io_regs_reg1_read_address; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 84:36]
  assign regs_reg2_read_address_clock = clock;
  assign regs_reg2_read_address_reset = reset;
  assign regs_reg2_read_address_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 91:36]
  assign regs_reg2_read_address_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 92:36]
  assign regs_reg2_read_address_io_in = io_regs_reg2_read_address; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 90:36]
  assign regs_write_enable_clock = clock;
  assign regs_write_enable_reset = reset;
  assign regs_write_enable_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 97:31]
  assign regs_write_enable_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 98:31]
  assign regs_write_enable_io_in = io_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 96:31]
  assign regs_write_address_clock = clock;
  assign regs_write_address_reset = reset;
  assign regs_write_address_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 103:32]
  assign regs_write_address_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 104:32]
  assign regs_write_address_io_in = io_regs_write_address; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 102:32]
  assign regs_write_source_clock = clock;
  assign regs_write_source_reset = reset;
  assign regs_write_source_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 109:31]
  assign regs_write_source_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 110:31]
  assign regs_write_source_io_in = io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 108:31]
  assign reg1_data_clock = clock;
  assign reg1_data_reset = reset;
  assign reg1_data_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 115:23]
  assign reg1_data_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 116:23]
  assign reg1_data_io_in = io_reg1_data; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 114:23]
  assign reg2_data_clock = clock;
  assign reg2_data_reset = reset;
  assign reg2_data_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 121:23]
  assign reg2_data_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 122:23]
  assign reg2_data_io_in = io_reg2_data; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 120:23]
  assign immediate_clock = clock;
  assign immediate_reset = reset;
  assign immediate_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 127:23]
  assign immediate_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 128:23]
  assign immediate_io_in = io_immediate; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 126:23]
  assign aluop1_source_clock = clock;
  assign aluop1_source_reset = reset;
  assign aluop1_source_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 133:27]
  assign aluop1_source_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 134:27]
  assign aluop1_source_io_in = io_aluop1_source; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 132:27]
  assign aluop2_source_clock = clock;
  assign aluop2_source_reset = reset;
  assign aluop2_source_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 139:27]
  assign aluop2_source_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 140:27]
  assign aluop2_source_io_in = io_aluop2_source; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 138:27]
  assign csr_write_enable_clock = clock;
  assign csr_write_enable_reset = reset;
  assign csr_write_enable_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 145:30]
  assign csr_write_enable_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 146:30]
  assign csr_write_enable_io_in = io_csr_write_enable; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 144:30]
  assign csr_address_clock = clock;
  assign csr_address_reset = reset;
  assign csr_address_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 151:25]
  assign csr_address_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 152:25]
  assign csr_address_io_in = io_csr_address; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 150:25]
  assign memory_read_enable_clock = clock;
  assign memory_read_enable_reset = reset;
  assign memory_read_enable_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 157:32]
  assign memory_read_enable_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 158:32]
  assign memory_read_enable_io_in = io_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 156:32]
  assign memory_write_enable_clock = clock;
  assign memory_write_enable_reset = reset;
  assign memory_write_enable_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 163:33]
  assign memory_write_enable_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 164:33]
  assign memory_write_enable_io_in = io_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 162:33]
  assign csr_read_data_clock = clock;
  assign csr_read_data_reset = reset;
  assign csr_read_data_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 169:27]
  assign csr_read_data_io_flush = io_flush; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 170:27]
  assign csr_read_data_io_in = io_csr_read_data; // @[4-soc/src/main/scala/riscv/core/ID2EX.scala 168:27]
endmodule
module ALU(
  input  [3:0]  io_func, // @[4-soc/src/main/scala/riscv/core/ALU.scala 38:14]
  input  [31:0] io_op1, // @[4-soc/src/main/scala/riscv/core/ALU.scala 38:14]
  input  [31:0] io_op2, // @[4-soc/src/main/scala/riscv/core/ALU.scala 38:14]
  output [31:0] io_result // @[4-soc/src/main/scala/riscv/core/ALU.scala 38:14]
);
  wire [31:0] _io_result_T_1 = io_op1 + io_op2; // @[4-soc/src/main/scala/riscv/core/ALU.scala 50:27]
  wire [31:0] _io_result_T_3 = io_op1 - io_op2; // @[4-soc/src/main/scala/riscv/core/ALU.scala 53:27]
  wire [62:0] _GEN_10 = {{31'd0}, io_op1}; // @[4-soc/src/main/scala/riscv/core/ALU.scala 56:27]
  wire [62:0] _io_result_T_5 = _GEN_10 << io_op2[4:0]; // @[4-soc/src/main/scala/riscv/core/ALU.scala 56:27]
  wire [31:0] _io_result_T_6 = io_op1; // @[4-soc/src/main/scala/riscv/core/ALU.scala 59:27]
  wire [31:0] _io_result_T_7 = io_op2; // @[4-soc/src/main/scala/riscv/core/ALU.scala 59:43]
  wire [31:0] _io_result_T_9 = io_op1 ^ io_op2; // @[4-soc/src/main/scala/riscv/core/ALU.scala 62:27]
  wire [31:0] _io_result_T_10 = io_op1 | io_op2; // @[4-soc/src/main/scala/riscv/core/ALU.scala 65:27]
  wire [31:0] _io_result_T_11 = io_op1 & io_op2; // @[4-soc/src/main/scala/riscv/core/ALU.scala 68:27]
  wire [31:0] _io_result_T_13 = io_op1 >> io_op2[4:0]; // @[4-soc/src/main/scala/riscv/core/ALU.scala 71:27]
  wire [31:0] _io_result_T_17 = $signed(io_op1) >>> io_op2[4:0]; // @[4-soc/src/main/scala/riscv/core/ALU.scala 74:52]
  wire  _GEN_0 = 4'ha == io_func & io_op1 < io_op2; // @[4-soc/src/main/scala/riscv/core/ALU.scala 47:13 48:19 77:17]
  wire [31:0] _GEN_1 = 4'h9 == io_func ? _io_result_T_17 : {{31'd0}, _GEN_0}; // @[4-soc/src/main/scala/riscv/core/ALU.scala 48:19 74:17]
  wire [31:0] _GEN_2 = 4'h8 == io_func ? _io_result_T_13 : _GEN_1; // @[4-soc/src/main/scala/riscv/core/ALU.scala 48:19 71:17]
  wire [31:0] _GEN_3 = 4'h7 == io_func ? _io_result_T_11 : _GEN_2; // @[4-soc/src/main/scala/riscv/core/ALU.scala 48:19 68:17]
  wire [31:0] _GEN_4 = 4'h6 == io_func ? _io_result_T_10 : _GEN_3; // @[4-soc/src/main/scala/riscv/core/ALU.scala 48:19 65:17]
  wire [31:0] _GEN_5 = 4'h5 == io_func ? _io_result_T_9 : _GEN_4; // @[4-soc/src/main/scala/riscv/core/ALU.scala 48:19 62:17]
  wire [31:0] _GEN_6 = 4'h4 == io_func ? {{31'd0}, $signed(_io_result_T_6) < $signed(_io_result_T_7)} : _GEN_5; // @[4-soc/src/main/scala/riscv/core/ALU.scala 48:19 59:17]
  wire [62:0] _GEN_7 = 4'h3 == io_func ? _io_result_T_5 : {{31'd0}, _GEN_6}; // @[4-soc/src/main/scala/riscv/core/ALU.scala 48:19 56:17]
  wire [62:0] _GEN_8 = 4'h2 == io_func ? {{31'd0}, _io_result_T_3} : _GEN_7; // @[4-soc/src/main/scala/riscv/core/ALU.scala 48:19 53:17]
  wire [62:0] _GEN_9 = 4'h1 == io_func ? {{31'd0}, _io_result_T_1} : _GEN_8; // @[4-soc/src/main/scala/riscv/core/ALU.scala 48:19 50:17]
  assign io_result = _GEN_9[31:0];
endmodule
module ALUControl(
  input  [6:0] io_opcode, // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 15:14]
  input  [2:0] io_funct3, // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 15:14]
  input  [6:0] io_funct7, // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 15:14]
  output [3:0] io_alu_funct // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 15:14]
);
  wire [3:0] _io_alu_funct_T_1 = io_funct7[5] ? 4'h9 : 4'h8; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 39:41]
  wire  _io_alu_funct_T_2 = 3'h1 == io_funct3; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire [1:0] _io_alu_funct_T_3 = 3'h1 == io_funct3 ? 2'h3 : 2'h1; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire  _io_alu_funct_T_4 = 3'h2 == io_funct3; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire [2:0] _io_alu_funct_T_5 = 3'h2 == io_funct3 ? 3'h4 : {{1'd0}, _io_alu_funct_T_3}; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire  _io_alu_funct_T_6 = 3'h3 == io_funct3; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire [3:0] _io_alu_funct_T_7 = 3'h3 == io_funct3 ? 4'ha : {{1'd0}, _io_alu_funct_T_5}; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire  _io_alu_funct_T_8 = 3'h4 == io_funct3; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire [3:0] _io_alu_funct_T_9 = 3'h4 == io_funct3 ? 4'h5 : _io_alu_funct_T_7; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire  _io_alu_funct_T_10 = 3'h6 == io_funct3; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire [3:0] _io_alu_funct_T_11 = 3'h6 == io_funct3 ? 4'h6 : _io_alu_funct_T_9; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire  _io_alu_funct_T_12 = 3'h7 == io_funct3; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire [3:0] _io_alu_funct_T_13 = 3'h7 == io_funct3 ? 4'h7 : _io_alu_funct_T_11; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire  _io_alu_funct_T_14 = 3'h5 == io_funct3; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire [3:0] _io_alu_funct_T_15 = 3'h5 == io_funct3 ? _io_alu_funct_T_1 : _io_alu_funct_T_13; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 30:8]
  wire [1:0] _io_alu_funct_T_17 = io_funct7[5] ? 2'h2 : 2'h1; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 49:43]
  wire [1:0] _io_alu_funct_T_21 = _io_alu_funct_T_2 ? 2'h3 : _io_alu_funct_T_17; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 47:8]
  wire [2:0] _io_alu_funct_T_23 = _io_alu_funct_T_4 ? 3'h4 : {{1'd0}, _io_alu_funct_T_21}; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 47:8]
  wire [3:0] _io_alu_funct_T_25 = _io_alu_funct_T_6 ? 4'ha : {{1'd0}, _io_alu_funct_T_23}; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 47:8]
  wire [3:0] _io_alu_funct_T_27 = _io_alu_funct_T_8 ? 4'h5 : _io_alu_funct_T_25; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 47:8]
  wire [3:0] _io_alu_funct_T_29 = _io_alu_funct_T_10 ? 4'h6 : _io_alu_funct_T_27; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 47:8]
  wire [3:0] _io_alu_funct_T_31 = _io_alu_funct_T_12 ? 4'h7 : _io_alu_funct_T_29; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 47:8]
  wire [3:0] _io_alu_funct_T_33 = _io_alu_funct_T_14 ? _io_alu_funct_T_1 : _io_alu_funct_T_31; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 47:8]
  wire  _GEN_1 = 7'h37 == io_opcode | 7'h17 == io_opcode; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 25:21 76:20]
  wire  _GEN_2 = 7'h67 == io_opcode | _GEN_1; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 25:21 73:20]
  wire  _GEN_3 = 7'h6f == io_opcode | _GEN_2; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 25:21 70:20]
  wire  _GEN_4 = 7'h23 == io_opcode | _GEN_3; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 25:21 67:20]
  wire  _GEN_5 = 7'h3 == io_opcode | _GEN_4; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 25:21 64:20]
  wire  _GEN_6 = 7'h63 == io_opcode | _GEN_5; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 25:21 61:20]
  wire [3:0] _GEN_7 = 7'h33 == io_opcode ? _io_alu_funct_T_33 : {{3'd0}, _GEN_6}; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 25:21 44:20]
  assign io_alu_funct = 7'h13 == io_opcode ? _io_alu_funct_T_15 : _GEN_7; // @[4-soc/src/main/scala/riscv/core/ALUControl.scala 25:21 27:20]
endmodule
module Execute(
  input  [31:0] io_instruction, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input  [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input  [31:0] io_reg1_data, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input  [31:0] io_reg2_data, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input  [31:0] io_immediate, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input         io_aluop1_source, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input         io_aluop2_source, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input  [31:0] io_csr_read_data, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input  [31:0] io_forward_from_mem, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input  [31:0] io_forward_from_wb, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input  [1:0]  io_reg1_forward, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  input  [1:0]  io_reg2_forward, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  output [31:0] io_mem_alu_result, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  output [31:0] io_mem_reg2_data, // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
  output [31:0] io_csr_write_data // @[4-soc/src/main/scala/riscv/core/Execute.scala 14:14]
);
  wire [3:0] alu_io_func; // @[4-soc/src/main/scala/riscv/core/Execute.scala 38:24]
  wire [31:0] alu_io_op1; // @[4-soc/src/main/scala/riscv/core/Execute.scala 38:24]
  wire [31:0] alu_io_op2; // @[4-soc/src/main/scala/riscv/core/Execute.scala 38:24]
  wire [31:0] alu_io_result; // @[4-soc/src/main/scala/riscv/core/Execute.scala 38:24]
  wire [6:0] alu_ctrl_io_opcode; // @[4-soc/src/main/scala/riscv/core/Execute.scala 39:24]
  wire [2:0] alu_ctrl_io_funct3; // @[4-soc/src/main/scala/riscv/core/Execute.scala 39:24]
  wire [6:0] alu_ctrl_io_funct7; // @[4-soc/src/main/scala/riscv/core/Execute.scala 39:24]
  wire [3:0] alu_ctrl_io_alu_funct; // @[4-soc/src/main/scala/riscv/core/Execute.scala 39:24]
  wire [2:0] funct3 = io_instruction[14:12]; // @[4-soc/src/main/scala/riscv/core/Execute.scala 34:30]
  wire [4:0] uimm = io_instruction[19:15]; // @[4-soc/src/main/scala/riscv/core/Execute.scala 36:30]
  wire [31:0] _reg1_data_T_1 = 2'h1 == io_reg1_forward ? io_forward_from_mem : io_reg1_data; // @[4-soc/src/main/scala/riscv/core/Execute.scala 49:4]
  wire [31:0] reg1_data = 2'h2 == io_reg1_forward ? io_forward_from_wb : _reg1_data_T_1; // @[4-soc/src/main/scala/riscv/core/Execute.scala 49:4]
  wire [31:0] _reg2_data_T_1 = 2'h1 == io_reg2_forward ? io_forward_from_mem : io_reg2_data; // @[4-soc/src/main/scala/riscv/core/Execute.scala 64:4]
  wire [31:0] reg2_data = 2'h2 == io_reg2_forward ? io_forward_from_wb : _reg2_data_T_1; // @[4-soc/src/main/scala/riscv/core/Execute.scala 64:4]
  wire [31:0] _io_csr_write_data_T = ~reg1_data; // @[4-soc/src/main/scala/riscv/core/Execute.scala 83:57]
  wire [31:0] _io_csr_write_data_T_1 = io_csr_read_data & _io_csr_write_data_T; // @[4-soc/src/main/scala/riscv/core/Execute.scala 83:55]
  wire [31:0] _io_csr_write_data_T_2 = io_csr_read_data | reg1_data; // @[4-soc/src/main/scala/riscv/core/Execute.scala 84:55]
  wire [31:0] _io_csr_write_data_T_3 = {27'h0,uimm}; // @[4-soc/src/main/scala/riscv/core/Execute.scala 85:40]
  wire [31:0] _io_csr_write_data_T_5 = ~_io_csr_write_data_T_3; // @[4-soc/src/main/scala/riscv/core/Execute.scala 86:57]
  wire [31:0] _io_csr_write_data_T_6 = io_csr_read_data & _io_csr_write_data_T_5; // @[4-soc/src/main/scala/riscv/core/Execute.scala 86:55]
  wire [31:0] _io_csr_write_data_T_8 = io_csr_read_data | _io_csr_write_data_T_3; // @[4-soc/src/main/scala/riscv/core/Execute.scala 87:55]
  wire [31:0] _io_csr_write_data_T_10 = 3'h1 == funct3 ? reg1_data : 32'h0; // @[4-soc/src/main/scala/riscv/core/Execute.scala 80:4]
  wire [31:0] _io_csr_write_data_T_12 = 3'h3 == funct3 ? _io_csr_write_data_T_1 : _io_csr_write_data_T_10; // @[4-soc/src/main/scala/riscv/core/Execute.scala 80:4]
  wire [31:0] _io_csr_write_data_T_14 = 3'h2 == funct3 ? _io_csr_write_data_T_2 : _io_csr_write_data_T_12; // @[4-soc/src/main/scala/riscv/core/Execute.scala 80:4]
  wire [31:0] _io_csr_write_data_T_16 = 3'h5 == funct3 ? _io_csr_write_data_T_3 : _io_csr_write_data_T_14; // @[4-soc/src/main/scala/riscv/core/Execute.scala 80:4]
  wire [31:0] _io_csr_write_data_T_18 = 3'h7 == funct3 ? _io_csr_write_data_T_6 : _io_csr_write_data_T_16; // @[4-soc/src/main/scala/riscv/core/Execute.scala 80:4]
  ALU alu ( // @[4-soc/src/main/scala/riscv/core/Execute.scala 38:24]
    .io_func(alu_io_func),
    .io_op1(alu_io_op1),
    .io_op2(alu_io_op2),
    .io_result(alu_io_result)
  );
  ALUControl alu_ctrl ( // @[4-soc/src/main/scala/riscv/core/Execute.scala 39:24]
    .io_opcode(alu_ctrl_io_opcode),
    .io_funct3(alu_ctrl_io_funct3),
    .io_funct7(alu_ctrl_io_funct7),
    .io_alu_funct(alu_ctrl_io_alu_funct)
  );
  assign io_mem_alu_result = alu_io_result; // @[4-soc/src/main/scala/riscv/core/Execute.scala 75:21]
  assign io_mem_reg2_data = 2'h2 == io_reg2_forward ? io_forward_from_wb : _reg2_data_T_1; // @[4-soc/src/main/scala/riscv/core/Execute.scala 64:4]
  assign io_csr_write_data = 3'h6 == funct3 ? _io_csr_write_data_T_8 : _io_csr_write_data_T_18; // @[4-soc/src/main/scala/riscv/core/Execute.scala 80:4]
  assign alu_io_func = alu_ctrl_io_alu_funct; // @[4-soc/src/main/scala/riscv/core/Execute.scala 44:22]
  assign alu_io_op1 = io_aluop1_source ? io_instruction_address : reg1_data; // @[4-soc/src/main/scala/riscv/core/Execute.scala 55:20]
  assign alu_io_op2 = io_aluop2_source ? io_immediate : reg2_data; // @[4-soc/src/main/scala/riscv/core/Execute.scala 70:20]
  assign alu_ctrl_io_opcode = io_instruction[6:0]; // @[4-soc/src/main/scala/riscv/core/Execute.scala 33:30]
  assign alu_ctrl_io_funct3 = io_instruction[14:12]; // @[4-soc/src/main/scala/riscv/core/Execute.scala 34:30]
  assign alu_ctrl_io_funct7 = io_instruction[31:25]; // @[4-soc/src/main/scala/riscv/core/Execute.scala 35:30]
endmodule
module PipelineRegister_30(
  input        clock,
  input        reset,
  input        io_stall, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  input  [2:0] io_in, // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
  output [2:0] io_out // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 24:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
  assign io_out = reg_; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 40:10]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
      reg_ <= 3'h0; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 31:20]
    end else if (~io_stall) begin // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 35:25]
      reg_ <= io_in; // @[4-soc/src/main/scala/riscv/core/PipelineRegister.scala 36:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module EX2MEM(
  input         clock,
  input         reset,
  input         io_stall, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  input         io_regs_write_enable, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  input  [1:0]  io_regs_write_source, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  input  [31:0] io_regs_write_address, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  input  [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  input  [2:0]  io_funct3, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  input  [31:0] io_reg2_data, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  input         io_memory_read_enable, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  input         io_memory_write_enable, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  input  [31:0] io_alu_result, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  input  [31:0] io_csr_read_data, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  output        io_output_regs_write_enable, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  output [1:0]  io_output_regs_write_source, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  output [31:0] io_output_regs_write_address, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  output [31:0] io_output_instruction_address, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  output [31:0] io_output_funct3, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  output [31:0] io_output_reg2_data, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  output        io_output_memory_read_enable, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  output        io_output_memory_write_enable, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  output [31:0] io_output_alu_result, // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
  output [31:0] io_output_csr_read_data // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 29:14]
);
  wire  regs_write_enable_clock; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 57:33]
  wire  regs_write_enable_reset; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 57:33]
  wire  regs_write_enable_io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 57:33]
  wire  regs_write_enable_io_flush; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 57:33]
  wire  regs_write_enable_io_in; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 57:33]
  wire  regs_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 57:33]
  wire  regs_write_source_clock; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 63:33]
  wire  regs_write_source_reset; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 63:33]
  wire  regs_write_source_io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 63:33]
  wire  regs_write_source_io_flush; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 63:33]
  wire [1:0] regs_write_source_io_in; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 63:33]
  wire [1:0] regs_write_source_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 63:33]
  wire  regs_write_address_clock; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 69:34]
  wire  regs_write_address_reset; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 69:34]
  wire  regs_write_address_io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 69:34]
  wire  regs_write_address_io_flush; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 69:34]
  wire [4:0] regs_write_address_io_in; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 69:34]
  wire [4:0] regs_write_address_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 69:34]
  wire  instruction_address_clock; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 75:35]
  wire  instruction_address_reset; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 75:35]
  wire  instruction_address_io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 75:35]
  wire  instruction_address_io_flush; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 75:35]
  wire [31:0] instruction_address_io_in; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 75:35]
  wire [31:0] instruction_address_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 75:35]
  wire  funct3_clock; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 81:22]
  wire  funct3_reset; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 81:22]
  wire  funct3_io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 81:22]
  wire [2:0] funct3_io_in; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 81:22]
  wire [2:0] funct3_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 81:22]
  wire  reg2_data_clock; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 87:25]
  wire  reg2_data_reset; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 87:25]
  wire  reg2_data_io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 87:25]
  wire  reg2_data_io_flush; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 87:25]
  wire [31:0] reg2_data_io_in; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 87:25]
  wire [31:0] reg2_data_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 87:25]
  wire  alu_result_clock; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 93:26]
  wire  alu_result_reset; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 93:26]
  wire  alu_result_io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 93:26]
  wire  alu_result_io_flush; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 93:26]
  wire [31:0] alu_result_io_in; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 93:26]
  wire [31:0] alu_result_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 93:26]
  wire  memory_read_enable_clock; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 99:34]
  wire  memory_read_enable_reset; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 99:34]
  wire  memory_read_enable_io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 99:34]
  wire  memory_read_enable_io_flush; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 99:34]
  wire  memory_read_enable_io_in; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 99:34]
  wire  memory_read_enable_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 99:34]
  wire  memory_write_enable_clock; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 105:35]
  wire  memory_write_enable_reset; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 105:35]
  wire  memory_write_enable_io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 105:35]
  wire  memory_write_enable_io_flush; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 105:35]
  wire  memory_write_enable_io_in; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 105:35]
  wire  memory_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 105:35]
  wire  csr_read_data_clock; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 111:29]
  wire  csr_read_data_reset; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 111:29]
  wire  csr_read_data_io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 111:29]
  wire  csr_read_data_io_flush; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 111:29]
  wire [31:0] csr_read_data_io_in; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 111:29]
  wire [31:0] csr_read_data_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 111:29]
  PipelineRegister_3 regs_write_enable ( // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 57:33]
    .clock(regs_write_enable_clock),
    .reset(regs_write_enable_reset),
    .io_stall(regs_write_enable_io_stall),
    .io_flush(regs_write_enable_io_flush),
    .io_in(regs_write_enable_io_in),
    .io_out(regs_write_enable_io_out)
  );
  PipelineRegister_15 regs_write_source ( // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 63:33]
    .clock(regs_write_source_clock),
    .reset(regs_write_source_reset),
    .io_stall(regs_write_source_io_stall),
    .io_flush(regs_write_source_io_flush),
    .io_in(regs_write_source_io_in),
    .io_out(regs_write_source_io_out)
  );
  PipelineRegister_11 regs_write_address ( // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 69:34]
    .clock(regs_write_address_clock),
    .reset(regs_write_address_reset),
    .io_stall(regs_write_address_io_stall),
    .io_flush(regs_write_address_io_flush),
    .io_in(regs_write_address_io_in),
    .io_out(regs_write_address_io_out)
  );
  PipelineRegister_2 instruction_address ( // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 75:35]
    .clock(instruction_address_clock),
    .reset(instruction_address_reset),
    .io_stall(instruction_address_io_stall),
    .io_flush(instruction_address_io_flush),
    .io_in(instruction_address_io_in),
    .io_out(instruction_address_io_out)
  );
  PipelineRegister_30 funct3 ( // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 81:22]
    .clock(funct3_clock),
    .reset(funct3_reset),
    .io_stall(funct3_io_stall),
    .io_in(funct3_io_in),
    .io_out(funct3_io_out)
  );
  PipelineRegister_2 reg2_data ( // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 87:25]
    .clock(reg2_data_clock),
    .reset(reg2_data_reset),
    .io_stall(reg2_data_io_stall),
    .io_flush(reg2_data_io_flush),
    .io_in(reg2_data_io_in),
    .io_out(reg2_data_io_out)
  );
  PipelineRegister_2 alu_result ( // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 93:26]
    .clock(alu_result_clock),
    .reset(alu_result_reset),
    .io_stall(alu_result_io_stall),
    .io_flush(alu_result_io_flush),
    .io_in(alu_result_io_in),
    .io_out(alu_result_io_out)
  );
  PipelineRegister_3 memory_read_enable ( // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 99:34]
    .clock(memory_read_enable_clock),
    .reset(memory_read_enable_reset),
    .io_stall(memory_read_enable_io_stall),
    .io_flush(memory_read_enable_io_flush),
    .io_in(memory_read_enable_io_in),
    .io_out(memory_read_enable_io_out)
  );
  PipelineRegister_3 memory_write_enable ( // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 105:35]
    .clock(memory_write_enable_clock),
    .reset(memory_write_enable_reset),
    .io_stall(memory_write_enable_io_stall),
    .io_flush(memory_write_enable_io_flush),
    .io_in(memory_write_enable_io_in),
    .io_out(memory_write_enable_io_out)
  );
  PipelineRegister_2 csr_read_data ( // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 111:29]
    .clock(csr_read_data_clock),
    .reset(csr_read_data_reset),
    .io_stall(csr_read_data_io_stall),
    .io_flush(csr_read_data_io_flush),
    .io_in(csr_read_data_io_in),
    .io_out(csr_read_data_io_out)
  );
  assign io_output_regs_write_enable = regs_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 61:31]
  assign io_output_regs_write_source = regs_write_source_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 67:31]
  assign io_output_regs_write_address = {{27'd0}, regs_write_address_io_out}; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 73:32]
  assign io_output_instruction_address = instruction_address_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 79:33]
  assign io_output_funct3 = {{29'd0}, funct3_io_out}; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 85:20]
  assign io_output_reg2_data = reg2_data_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 91:23]
  assign io_output_memory_read_enable = memory_read_enable_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 103:32]
  assign io_output_memory_write_enable = memory_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 109:33]
  assign io_output_alu_result = alu_result_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 97:24]
  assign io_output_csr_read_data = csr_read_data_io_out; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 115:27]
  assign regs_write_enable_clock = clock;
  assign regs_write_enable_reset = reset;
  assign regs_write_enable_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 59:31]
  assign regs_write_enable_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 60:31]
  assign regs_write_enable_io_in = io_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 58:31]
  assign regs_write_source_clock = clock;
  assign regs_write_source_reset = reset;
  assign regs_write_source_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 65:31]
  assign regs_write_source_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 66:31]
  assign regs_write_source_io_in = io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 64:31]
  assign regs_write_address_clock = clock;
  assign regs_write_address_reset = reset;
  assign regs_write_address_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 71:32]
  assign regs_write_address_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 72:32]
  assign regs_write_address_io_in = io_regs_write_address[4:0]; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 70:32]
  assign instruction_address_clock = clock;
  assign instruction_address_reset = reset;
  assign instruction_address_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 77:33]
  assign instruction_address_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 78:33]
  assign instruction_address_io_in = io_instruction_address; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 76:33]
  assign funct3_clock = clock;
  assign funct3_reset = reset;
  assign funct3_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 83:20]
  assign funct3_io_in = io_funct3; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 82:20]
  assign reg2_data_clock = clock;
  assign reg2_data_reset = reset;
  assign reg2_data_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 89:23]
  assign reg2_data_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 90:23]
  assign reg2_data_io_in = io_reg2_data; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 88:23]
  assign alu_result_clock = clock;
  assign alu_result_reset = reset;
  assign alu_result_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 95:24]
  assign alu_result_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 96:24]
  assign alu_result_io_in = io_alu_result; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 94:24]
  assign memory_read_enable_clock = clock;
  assign memory_read_enable_reset = reset;
  assign memory_read_enable_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 101:32]
  assign memory_read_enable_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 102:32]
  assign memory_read_enable_io_in = io_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 100:32]
  assign memory_write_enable_clock = clock;
  assign memory_write_enable_reset = reset;
  assign memory_write_enable_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 107:33]
  assign memory_write_enable_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 108:33]
  assign memory_write_enable_io_in = io_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 106:33]
  assign csr_read_data_clock = clock;
  assign csr_read_data_reset = reset;
  assign csr_read_data_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 113:27]
  assign csr_read_data_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 114:27]
  assign csr_read_data_io_in = io_csr_read_data; // @[4-soc/src/main/scala/riscv/core/EX2MEM.scala 112:27]
endmodule
module MemoryAccess(
  input         clock,
  input         reset,
  input  [31:0] io_alu_result, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input  [31:0] io_reg2_data, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input         io_memory_read_enable, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input         io_memory_write_enable, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input  [2:0]  io_funct3, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input  [1:0]  io_regs_write_source, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input  [4:0]  io_regs_write_address, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input         io_regs_write_enable, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input  [31:0] io_csr_read_data, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input  [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output [31:0] io_wb_memory_read_data, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output [31:0] io_forward_to_ex, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output        io_ctrl_stall_flag, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output [1:0]  io_wb_regs_write_source, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output [4:0]  io_wb_regs_write_address, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output        io_wb_regs_write_enable, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output [31:0] io_bus_address, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output        io_bus_read, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input  [31:0] io_bus_read_data, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input         io_bus_read_valid, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output        io_bus_write, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output [31:0] io_bus_write_data, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output        io_bus_write_strobe_0, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output        io_bus_write_strobe_1, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output        io_bus_write_strobe_2, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output        io_bus_write_strobe_3, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input         io_bus_write_valid, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  output        io_bus_request, // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
  input         io_bus_granted // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 44:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire [1:0] mem_address_index = io_alu_result[1:0]; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 67:40]
  reg [1:0] mem_access_state; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 68:34]
  reg [31:0] latched_memory_read_data; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 72:41]
  reg [1:0] latched_regs_write_source; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 79:43]
  reg [4:0] latched_regs_write_address; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 80:43]
  reg  latched_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 81:43]
  wire  _T = mem_access_state == 2'h1; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 134:25]
  wire [23:0] _processed_data_T_1 = io_bus_read_data[31] ? 24'hffffff : 24'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 150:21]
  wire [31:0] _processed_data_T_3 = {_processed_data_T_1,io_bus_read_data[31:24]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 150:16]
  wire [23:0] _processed_data_T_5 = io_bus_read_data[7] ? 24'hffffff : 24'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 152:30]
  wire [31:0] _processed_data_T_7 = {_processed_data_T_5,io_bus_read_data[7:0]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 152:25]
  wire [23:0] _processed_data_T_9 = io_bus_read_data[15] ? 24'hffffff : 24'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 153:30]
  wire [31:0] _processed_data_T_11 = {_processed_data_T_9,io_bus_read_data[15:8]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 153:25]
  wire [23:0] _processed_data_T_13 = io_bus_read_data[23] ? 24'hffffff : 24'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 154:30]
  wire [31:0] _processed_data_T_15 = {_processed_data_T_13,io_bus_read_data[23:16]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 154:25]
  wire  _processed_data_T_16 = 2'h0 == mem_address_index; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_17 = 2'h0 == mem_address_index ? _processed_data_T_7 : _processed_data_T_3; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire  _processed_data_T_18 = 2'h1 == mem_address_index; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_19 = 2'h1 == mem_address_index ? _processed_data_T_11 : _processed_data_T_17; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire  _processed_data_T_20 = 2'h2 == mem_address_index; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_21 = 2'h2 == mem_address_index ? _processed_data_T_15 : _processed_data_T_19; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_24 = {24'h0,io_bus_read_data[31:24]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 159:16]
  wire [31:0] _processed_data_T_27 = {24'h0,io_bus_read_data[7:0]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 161:25]
  wire [31:0] _processed_data_T_30 = {24'h0,io_bus_read_data[15:8]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 162:25]
  wire [31:0] _processed_data_T_33 = {24'h0,io_bus_read_data[23:16]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 163:25]
  wire [31:0] _processed_data_T_35 = 2'h0 == mem_address_index ? _processed_data_T_27 : _processed_data_T_24; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_37 = 2'h1 == mem_address_index ? _processed_data_T_30 : _processed_data_T_35; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_39 = 2'h2 == mem_address_index ? _processed_data_T_33 : _processed_data_T_37; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [15:0] _processed_data_T_41 = io_bus_read_data[31] ? 16'hffff : 16'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 168:21]
  wire [31:0] _processed_data_T_43 = {_processed_data_T_41,io_bus_read_data[31:16]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 168:16]
  wire [15:0] _processed_data_T_45 = io_bus_read_data[15] ? 16'hffff : 16'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 170:30]
  wire [31:0] _processed_data_T_47 = {_processed_data_T_45,io_bus_read_data[15:0]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 170:25]
  wire [15:0] _processed_data_T_49 = io_bus_read_data[23] ? 16'hffff : 16'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 171:30]
  wire [31:0] _processed_data_T_51 = {_processed_data_T_49,io_bus_read_data[23:8]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 171:25]
  wire [31:0] _processed_data_T_57 = 2'h0 == mem_address_index ? _processed_data_T_47 : _processed_data_T_43; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_59 = 2'h1 == mem_address_index ? _processed_data_T_51 : _processed_data_T_57; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_61 = 2'h2 == mem_address_index ? _processed_data_T_43 : _processed_data_T_59; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_64 = {16'h0,io_bus_read_data[31:16]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 177:16]
  wire [31:0] _processed_data_T_67 = {16'h0,io_bus_read_data[15:0]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 179:25]
  wire [31:0] _processed_data_T_70 = {16'h0,io_bus_read_data[23:8]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 180:25]
  wire [31:0] _processed_data_T_75 = 2'h0 == mem_address_index ? _processed_data_T_67 : _processed_data_T_64; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_77 = 2'h1 == mem_address_index ? _processed_data_T_70 : _processed_data_T_75; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_79 = 2'h2 == mem_address_index ? _processed_data_T_64 : _processed_data_T_77; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_81 = 3'h0 == io_funct3 ? _processed_data_T_21 : 32'h0; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_83 = 3'h4 == io_funct3 ? _processed_data_T_39 : _processed_data_T_81; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_85 = 3'h1 == io_funct3 ? _processed_data_T_61 : _processed_data_T_83; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _processed_data_T_87 = 3'h5 == io_funct3 ? _processed_data_T_79 : _processed_data_T_85; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] processed_data = 3'h2 == io_funct3 ? io_bus_read_data : _processed_data_T_87; // @[src/main/scala/chisel3/util/Mux.scala 77:13]
  wire [31:0] _GEN_1 = io_bus_read_valid ? processed_data : latched_memory_read_data; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 138:29 188:32 72:41]
  wire  _GEN_4 = io_bus_read_valid ? 1'h0 : 1'h1; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 137:24 138:29 95:24]
  wire  _GEN_6 = io_bus_write_valid ? 1'h0 : 1'h1; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 206:24 208:30 95:24]
  wire [1:0] _GEN_7 = io_bus_granted ? 2'h1 : mem_access_state; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 224:28 225:26 68:34]
  wire  _GEN_11 = 2'h3 == mem_address_index; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 232:27 234:{48,48}]
  wire [4:0] _io_bus_write_data_T_1 = {mem_address_index, 3'h0}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 236:93]
  wire [38:0] _GEN_85 = {{31'd0}, io_reg2_data[7:0]}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 236:71]
  wire [38:0] _io_bus_write_data_T_2 = _GEN_85 << _io_bus_write_data_T_1; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 236:71]
  wire  _T_4 = mem_address_index == 2'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 240:32]
  wire  _T_5 = mem_address_index == 2'h1; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 245:38]
  wire [23:0] _GEN_0 = {io_reg2_data[15:0], 8'h0}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 249:57]
  wire [30:0] _io_bus_write_data_T_5 = {{7'd0}, _GEN_0}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 249:57]
  wire [31:0] _GEN_2 = {io_reg2_data[15:0], 16'h0}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 254:57]
  wire [46:0] _io_bus_write_data_T_7 = {{15'd0}, _GEN_2}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 254:57]
  wire [46:0] _GEN_13 = mem_address_index == 2'h2 ? _io_bus_write_data_T_7 : _io_bus_write_data_T_7; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 250:47 254:34 259:34]
  wire [46:0] _GEN_16 = mem_address_index == 2'h1 ? {{16'd0}, _io_bus_write_data_T_5} : _GEN_13; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 245:47 249:34]
  wire  _GEN_17 = mem_address_index == 2'h1 ? 1'h0 : 1'h1; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 232:27 245:47]
  wire  _GEN_19 = mem_address_index == 2'h0 | _T_5; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 240:41 243:34]
  wire [46:0] _GEN_20 = mem_address_index == 2'h0 ? {{31'd0}, io_reg2_data[15:0]} : _GEN_16; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 240:41 244:34]
  wire  _GEN_21 = mem_address_index == 2'h0 ? 1'h0 : 1'h1; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 232:27 240:41]
  wire  _GEN_22 = mem_address_index == 2'h0 ? 1'h0 : _GEN_17; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 232:27 240:41]
  wire  _T_7 = io_funct3 == 3'h2; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 261:28]
  wire  _GEN_27 = io_funct3 == 3'h1 ? _T_4 : _T_7; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 239:54]
  wire  _GEN_28 = io_funct3 == 3'h1 ? _GEN_19 : _T_7; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 239:54]
  wire [46:0] _GEN_29 = io_funct3 == 3'h1 ? _GEN_20 : {{15'd0}, io_reg2_data}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 230:27 239:54]
  wire  _GEN_30 = io_funct3 == 3'h1 ? _GEN_21 : _T_7; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 239:54]
  wire  _GEN_31 = io_funct3 == 3'h1 ? _GEN_22 : _T_7; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 239:54]
  wire  _GEN_32 = io_funct3 == 3'h0 ? _processed_data_T_16 : _GEN_27; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 233:48]
  wire  _GEN_33 = io_funct3 == 3'h0 ? _processed_data_T_18 : _GEN_28; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 233:48]
  wire  _GEN_34 = io_funct3 == 3'h0 ? _processed_data_T_20 : _GEN_30; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 233:48]
  wire  _GEN_35 = io_funct3 == 3'h0 ? _GEN_11 : _GEN_31; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 233:48]
  wire [46:0] _GEN_36 = io_funct3 == 3'h0 ? {{8'd0}, _io_bus_write_data_T_2} : _GEN_29; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 233:48 236:27]
  wire [1:0] _GEN_37 = io_bus_granted ? 2'h2 : mem_access_state; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 267:28 268:26 68:34]
  wire [46:0] _GEN_39 = io_memory_write_enable ? _GEN_36 : 47'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 114:26 227:40]
  wire  _GEN_40 = io_memory_write_enable & _GEN_32; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 227:40]
  wire  _GEN_41 = io_memory_write_enable & _GEN_33; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 227:40]
  wire  _GEN_42 = io_memory_write_enable & _GEN_34; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 227:40]
  wire  _GEN_43 = io_memory_write_enable & _GEN_35; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 227:40]
  wire [1:0] _GEN_44 = io_memory_write_enable ? _GEN_37 : mem_access_state; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 227:40 68:34]
  wire  _GEN_45 = io_memory_read_enable | io_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 213:33 215:26]
  wire [46:0] _GEN_51 = io_memory_read_enable ? 47'h0 : _GEN_39; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 114:26 213:33]
  wire  _GEN_52 = io_memory_read_enable ? 1'h0 : io_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 116:26 213:33]
  wire  _GEN_53 = io_memory_read_enable ? 1'h0 : _GEN_40; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 213:33]
  wire  _GEN_54 = io_memory_read_enable ? 1'h0 : _GEN_41; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 213:33]
  wire  _GEN_55 = io_memory_read_enable ? 1'h0 : _GEN_42; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 213:33]
  wire  _GEN_56 = io_memory_read_enable ? 1'h0 : _GEN_43; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 213:33]
  wire  _GEN_57 = mem_access_state == 2'h2 | _GEN_45; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 197:61 205:24]
  wire  _GEN_58 = mem_access_state == 2'h2 ? _GEN_6 : _GEN_45; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 197:61]
  wire  _GEN_60 = mem_access_state == 2'h2 ? 1'h0 : io_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 110:18 197:61]
  wire [46:0] _GEN_64 = mem_access_state == 2'h2 ? 47'h0 : _GEN_51; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 114:26 197:61]
  wire  _GEN_65 = mem_access_state == 2'h2 ? 1'h0 : _GEN_52; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 116:26 197:61]
  wire  _GEN_66 = mem_access_state == 2'h2 ? 1'h0 : _GEN_53; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 197:61]
  wire  _GEN_67 = mem_access_state == 2'h2 ? 1'h0 : _GEN_54; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 197:61]
  wire  _GEN_68 = mem_access_state == 2'h2 ? 1'h0 : _GEN_55; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 197:61]
  wire  _GEN_69 = mem_access_state == 2'h2 ? 1'h0 : _GEN_56; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 197:61]
  wire [46:0] _GEN_79 = mem_access_state == 2'h1 ? 47'h0 : _GEN_64; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 114:26 134:54]
  wire  in_active_read = _T & ~io_bus_read_valid; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 301:69]
  wire [1:0] forward_regs_write_source = in_active_read ? latched_regs_write_source : io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 304:38]
  wire [31:0] _io_forward_to_ex_T_1 = io_instruction_address + 32'h4; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 335:72]
  wire [31:0] _io_forward_to_ex_T_3 = 2'h1 == forward_regs_write_source ? io_wb_memory_read_data : io_alu_result; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 331:74]
  wire [31:0] _io_forward_to_ex_T_5 = 2'h2 == forward_regs_write_source ? io_csr_read_data : _io_forward_to_ex_T_3; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 331:74]
  assign io_wb_memory_read_data = mem_access_state == 2'h1 ? _GEN_1 : latched_memory_read_data; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 134:54 72:41]
  assign io_forward_to_ex = 2'h3 == forward_regs_write_source ? _io_forward_to_ex_T_1 : _io_forward_to_ex_T_5; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 331:74]
  assign io_ctrl_stall_flag = mem_access_state == 2'h1 ? _GEN_4 : _GEN_58; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 134:54]
  assign io_wb_regs_write_source = in_active_read ? latched_regs_write_source : io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 310:43]
  assign io_wb_regs_write_address = in_active_read ? latched_regs_write_address : io_regs_write_address; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 315:44]
  assign io_wb_regs_write_enable = in_active_read ? latched_regs_write_enable : io_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 320:43]
  assign io_bus_address = {io_alu_result[31:2],2'h0}; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 111:89]
  assign io_bus_read = mem_access_state == 2'h1 ? 1'h0 : _GEN_60; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 110:18 134:54]
  assign io_bus_write = mem_access_state == 2'h1 ? 1'h0 : _GEN_65; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 116:26 134:54]
  assign io_bus_write_data = _GEN_79[31:0];
  assign io_bus_write_strobe_0 = mem_access_state == 2'h1 ? 1'h0 : _GEN_66; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 134:54]
  assign io_bus_write_strobe_1 = mem_access_state == 2'h1 ? 1'h0 : _GEN_67; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 134:54]
  assign io_bus_write_strobe_2 = mem_access_state == 2'h1 ? 1'h0 : _GEN_68; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 134:54]
  assign io_bus_write_strobe_3 = mem_access_state == 2'h1 ? 1'h0 : _GEN_69; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 115:26 134:54]
  assign io_bus_request = mem_access_state == 2'h1 | _GEN_57; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 134:54 136:24]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 68:34]
      mem_access_state <= 2'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 68:34]
    end else if (mem_access_state == 2'h1) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 134:54]
      if (io_bus_read_valid) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 138:29]
        mem_access_state <= 2'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 94:24]
      end
    end else if (mem_access_state == 2'h2) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 197:61]
      if (io_bus_write_valid) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 208:30]
        mem_access_state <= 2'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 94:24]
      end
    end else if (io_memory_read_enable) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 213:33]
      mem_access_state <= _GEN_7;
    end else begin
      mem_access_state <= _GEN_44;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 72:41]
      latched_memory_read_data <= 32'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 72:41]
    end else if (mem_access_state == 2'h1) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 134:54]
      if (io_bus_read_valid) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 138:29]
        if (3'h2 == io_funct3) begin // @[src/main/scala/chisel3/util/Mux.scala 77:13]
          latched_memory_read_data <= io_bus_read_data;
        end else begin
          latched_memory_read_data <= _processed_data_T_87;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 79:43]
      latched_regs_write_source <= 2'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 79:43]
    end else if (!(mem_access_state == 2'h1)) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 134:54]
      if (!(mem_access_state == 2'h2)) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 197:61]
        if (io_memory_read_enable) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 213:33]
          latched_regs_write_source <= io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 221:34]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 80:43]
      latched_regs_write_address <= 5'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 80:43]
    end else if (!(mem_access_state == 2'h1)) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 134:54]
      if (!(mem_access_state == 2'h2)) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 197:61]
        if (io_memory_read_enable) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 213:33]
          latched_regs_write_address <= io_regs_write_address; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 222:34]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 81:43]
      latched_regs_write_enable <= 1'h0; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 81:43]
    end else if (!(mem_access_state == 2'h1)) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 134:54]
      if (!(mem_access_state == 2'h2)) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 197:61]
        if (io_memory_read_enable) begin // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 213:33]
          latched_regs_write_enable <= io_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/MemoryAccess.scala 223:34]
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mem_access_state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  latched_memory_read_data = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  latched_regs_write_source = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  latched_regs_write_address = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  latched_regs_write_enable = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MEM2WB(
  input         clock,
  input         reset,
  input         io_stall, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  input  [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  input  [31:0] io_alu_result, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  input         io_regs_write_enable, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  input  [1:0]  io_regs_write_source, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  input  [31:0] io_regs_write_address, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  input  [31:0] io_memory_read_data, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  input  [31:0] io_csr_read_data, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  output [31:0] io_output_instruction_address, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  output [31:0] io_output_alu_result, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  output        io_output_regs_write_enable, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  output [1:0]  io_output_regs_write_source, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  output [31:0] io_output_regs_write_address, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  output [31:0] io_output_memory_read_data, // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
  output [31:0] io_output_csr_read_data // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 29:14]
);
  wire  alu_result_clock; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 50:26]
  wire  alu_result_reset; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 50:26]
  wire  alu_result_io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 50:26]
  wire  alu_result_io_flush; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 50:26]
  wire [31:0] alu_result_io_in; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 50:26]
  wire [31:0] alu_result_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 50:26]
  wire  memory_read_data_clock; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 56:32]
  wire  memory_read_data_reset; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 56:32]
  wire  memory_read_data_io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 56:32]
  wire  memory_read_data_io_flush; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 56:32]
  wire [31:0] memory_read_data_io_in; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 56:32]
  wire [31:0] memory_read_data_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 56:32]
  wire  regs_write_enable_clock; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 62:33]
  wire  regs_write_enable_reset; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 62:33]
  wire  regs_write_enable_io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 62:33]
  wire  regs_write_enable_io_flush; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 62:33]
  wire  regs_write_enable_io_in; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 62:33]
  wire  regs_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 62:33]
  wire  regs_write_source_clock; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 68:33]
  wire  regs_write_source_reset; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 68:33]
  wire  regs_write_source_io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 68:33]
  wire  regs_write_source_io_flush; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 68:33]
  wire [1:0] regs_write_source_io_in; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 68:33]
  wire [1:0] regs_write_source_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 68:33]
  wire  regs_write_address_clock; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 74:34]
  wire  regs_write_address_reset; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 74:34]
  wire  regs_write_address_io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 74:34]
  wire  regs_write_address_io_flush; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 74:34]
  wire [4:0] regs_write_address_io_in; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 74:34]
  wire [4:0] regs_write_address_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 74:34]
  wire  instruction_address_clock; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 80:35]
  wire  instruction_address_reset; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 80:35]
  wire  instruction_address_io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 80:35]
  wire  instruction_address_io_flush; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 80:35]
  wire [31:0] instruction_address_io_in; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 80:35]
  wire [31:0] instruction_address_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 80:35]
  wire  csr_read_data_clock; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 86:29]
  wire  csr_read_data_reset; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 86:29]
  wire  csr_read_data_io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 86:29]
  wire  csr_read_data_io_flush; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 86:29]
  wire [31:0] csr_read_data_io_in; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 86:29]
  wire [31:0] csr_read_data_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 86:29]
  PipelineRegister_2 alu_result ( // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 50:26]
    .clock(alu_result_clock),
    .reset(alu_result_reset),
    .io_stall(alu_result_io_stall),
    .io_flush(alu_result_io_flush),
    .io_in(alu_result_io_in),
    .io_out(alu_result_io_out)
  );
  PipelineRegister_2 memory_read_data ( // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 56:32]
    .clock(memory_read_data_clock),
    .reset(memory_read_data_reset),
    .io_stall(memory_read_data_io_stall),
    .io_flush(memory_read_data_io_flush),
    .io_in(memory_read_data_io_in),
    .io_out(memory_read_data_io_out)
  );
  PipelineRegister_3 regs_write_enable ( // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 62:33]
    .clock(regs_write_enable_clock),
    .reset(regs_write_enable_reset),
    .io_stall(regs_write_enable_io_stall),
    .io_flush(regs_write_enable_io_flush),
    .io_in(regs_write_enable_io_in),
    .io_out(regs_write_enable_io_out)
  );
  PipelineRegister_15 regs_write_source ( // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 68:33]
    .clock(regs_write_source_clock),
    .reset(regs_write_source_reset),
    .io_stall(regs_write_source_io_stall),
    .io_flush(regs_write_source_io_flush),
    .io_in(regs_write_source_io_in),
    .io_out(regs_write_source_io_out)
  );
  PipelineRegister_11 regs_write_address ( // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 74:34]
    .clock(regs_write_address_clock),
    .reset(regs_write_address_reset),
    .io_stall(regs_write_address_io_stall),
    .io_flush(regs_write_address_io_flush),
    .io_in(regs_write_address_io_in),
    .io_out(regs_write_address_io_out)
  );
  PipelineRegister_2 instruction_address ( // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 80:35]
    .clock(instruction_address_clock),
    .reset(instruction_address_reset),
    .io_stall(instruction_address_io_stall),
    .io_flush(instruction_address_io_flush),
    .io_in(instruction_address_io_in),
    .io_out(instruction_address_io_out)
  );
  PipelineRegister_2 csr_read_data ( // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 86:29]
    .clock(csr_read_data_clock),
    .reset(csr_read_data_reset),
    .io_stall(csr_read_data_io_stall),
    .io_flush(csr_read_data_io_flush),
    .io_in(csr_read_data_io_in),
    .io_out(csr_read_data_io_out)
  );
  assign io_output_instruction_address = instruction_address_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 84:33]
  assign io_output_alu_result = alu_result_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 54:24]
  assign io_output_regs_write_enable = regs_write_enable_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 66:31]
  assign io_output_regs_write_source = regs_write_source_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 72:31]
  assign io_output_regs_write_address = {{27'd0}, regs_write_address_io_out}; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 78:32]
  assign io_output_memory_read_data = memory_read_data_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 60:30]
  assign io_output_csr_read_data = csr_read_data_io_out; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 90:27]
  assign alu_result_clock = clock;
  assign alu_result_reset = reset;
  assign alu_result_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 52:24]
  assign alu_result_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 53:24]
  assign alu_result_io_in = io_alu_result; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 51:24]
  assign memory_read_data_clock = clock;
  assign memory_read_data_reset = reset;
  assign memory_read_data_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 58:30]
  assign memory_read_data_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 59:30]
  assign memory_read_data_io_in = io_memory_read_data; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 57:30]
  assign regs_write_enable_clock = clock;
  assign regs_write_enable_reset = reset;
  assign regs_write_enable_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 64:31]
  assign regs_write_enable_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 65:31]
  assign regs_write_enable_io_in = io_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 63:31]
  assign regs_write_source_clock = clock;
  assign regs_write_source_reset = reset;
  assign regs_write_source_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 70:31]
  assign regs_write_source_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 71:31]
  assign regs_write_source_io_in = io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 69:31]
  assign regs_write_address_clock = clock;
  assign regs_write_address_reset = reset;
  assign regs_write_address_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 76:32]
  assign regs_write_address_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 77:32]
  assign regs_write_address_io_in = io_regs_write_address[4:0]; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 75:32]
  assign instruction_address_clock = clock;
  assign instruction_address_reset = reset;
  assign instruction_address_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 82:33]
  assign instruction_address_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 83:33]
  assign instruction_address_io_in = io_instruction_address; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 81:33]
  assign csr_read_data_clock = clock;
  assign csr_read_data_reset = reset;
  assign csr_read_data_io_stall = io_stall; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 88:27]
  assign csr_read_data_io_flush = 1'h0; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 89:27]
  assign csr_read_data_io_in = io_csr_read_data; // @[4-soc/src/main/scala/riscv/core/MEM2WB.scala 87:27]
endmodule
module WriteBack(
  input  [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/WriteBack.scala 12:14]
  input  [31:0] io_alu_result, // @[4-soc/src/main/scala/riscv/core/WriteBack.scala 12:14]
  input  [31:0] io_memory_read_data, // @[4-soc/src/main/scala/riscv/core/WriteBack.scala 12:14]
  input  [1:0]  io_regs_write_source, // @[4-soc/src/main/scala/riscv/core/WriteBack.scala 12:14]
  input  [31:0] io_csr_read_data, // @[4-soc/src/main/scala/riscv/core/WriteBack.scala 12:14]
  output [31:0] io_regs_write_data // @[4-soc/src/main/scala/riscv/core/WriteBack.scala 12:14]
);
  wire [31:0] _io_regs_write_data_T_1 = io_instruction_address + 32'h4; // @[4-soc/src/main/scala/riscv/core/WriteBack.scala 28:72]
  wire [31:0] _io_regs_write_data_T_3 = 2'h1 == io_regs_write_source ? io_memory_read_data : io_alu_result; // @[4-soc/src/main/scala/riscv/core/WriteBack.scala 24:4]
  wire [31:0] _io_regs_write_data_T_5 = 2'h2 == io_regs_write_source ? io_csr_read_data : _io_regs_write_data_T_3; // @[4-soc/src/main/scala/riscv/core/WriteBack.scala 24:4]
  assign io_regs_write_data = 2'h3 == io_regs_write_source ? _io_regs_write_data_T_1 : _io_regs_write_data_T_5; // @[4-soc/src/main/scala/riscv/core/WriteBack.scala 24:4]
endmodule
module Forwarding(
  input  [4:0] io_rs1_id, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  input  [4:0] io_rs2_id, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  input  [4:0] io_rs1_ex, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  input  [4:0] io_rs2_ex, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  input  [4:0] io_rd_mem, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  input        io_reg_write_enable_mem, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  input  [4:0] io_rd_wb, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  input        io_reg_write_enable_wb, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  output [1:0] io_reg1_forward_id, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  output [1:0] io_reg2_forward_id, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  output [1:0] io_reg1_forward_ex, // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
  output [1:0] io_reg2_forward_ex // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 60:14]
);
  wire  _T_2 = io_rd_mem != 5'h0; // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 80:72]
  wire  _T_6 = io_rd_wb != 5'h0; // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 84:75]
  wire [1:0] _GEN_0 = io_reg_write_enable_wb & io_rs1_ex == io_rd_wb & io_rd_wb != 5'h0 ? 2'h2 : 2'h0; // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 84:84 87:24 90:24]
  wire [1:0] _GEN_2 = io_reg_write_enable_wb & io_rs2_ex == io_rd_wb & _T_6 ? 2'h2 : 2'h0; // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 100:24 103:24 98:84]
  wire [1:0] _GEN_4 = io_reg_write_enable_wb & io_rs1_id == io_rd_wb & _T_6 ? 2'h2 : 2'h0; // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 117:84 119:24 122:24]
  wire [1:0] _GEN_6 = io_reg_write_enable_wb & io_rs2_id == io_rd_wb & _T_6 ? 2'h2 : 2'h0; // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 131:84 133:24 136:24]
  assign io_reg1_forward_id = io_reg_write_enable_mem & io_rs1_id == io_rd_mem & _T_2 ? 2'h1 : _GEN_4; // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 111:81 116:24]
  assign io_reg2_forward_id = io_reg_write_enable_mem & io_rs2_id == io_rd_mem & _T_2 ? 2'h1 : _GEN_6; // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 126:81 130:24]
  assign io_reg1_forward_ex = io_reg_write_enable_mem & io_rs1_ex == io_rd_mem & io_rd_mem != 5'h0 ? 2'h1 : _GEN_0; // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 80:81 83:24]
  assign io_reg2_forward_ex = io_reg_write_enable_mem & io_rs2_ex == io_rd_mem & _T_2 ? 2'h1 : _GEN_2; // @[4-soc/src/main/scala/riscv/core/Forwarding.scala 94:81 97:24]
endmodule
module CLINT(
  input  [31:0] io_interrupt_flag, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  input  [31:0] io_instruction_id, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  input  [31:0] io_instruction_address_if, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  input         io_jump_flag, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  input  [31:0] io_jump_address, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  output [31:0] io_id_interrupt_handler_address, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  output        io_id_interrupt_assert, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  input  [31:0] io_csr_bundle_mstatus, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  input  [31:0] io_csr_bundle_mepc, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  input  [31:0] io_csr_bundle_mcause, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  input  [31:0] io_csr_bundle_mtvec, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  input  [31:0] io_csr_bundle_mie, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  output [31:0] io_csr_bundle_mstatus_write_data, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  output [31:0] io_csr_bundle_mepc_write_data, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  output [31:0] io_csr_bundle_mcause_write_data, // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
  output        io_csr_bundle_direct_write_enable // @[4-soc/src/main/scala/riscv/core/CLINT.scala 20:14]
);
  wire  interrupt_enable_global = io_csr_bundle_mstatus[3]; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 34:56]
  wire  interrupt_enable_timer = io_csr_bundle_mie[7]; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 35:52]
  wire  interrupt_enable_external = io_csr_bundle_mie[11]; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 36:52]
  wire [31:0] instruction_address = io_jump_flag ? io_jump_address : io_instruction_address_if; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 38:32]
  wire [31:0] mstatus_disable_interrupt = {io_csr_bundle_mstatus[31:8],interrupt_enable_global,io_csr_bundle_mstatus[6:4
    ],1'h0,io_csr_bundle_mstatus[2:0]}; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 45:105]
  wire [31:0] mstatus_recover_interrupt = {io_csr_bundle_mstatus[31:8],1'h1,io_csr_bundle_mstatus[6:4],
    io_csr_bundle_mstatus[7],io_csr_bundle_mstatus[2:0]}; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 49:105]
  wire  interrupt_source_enabled = io_interrupt_flag[0] ? interrupt_enable_timer : interrupt_enable_external; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 53:37]
  wire [3:0] _io_csr_bundle_mcause_write_data_T_1 = 32'h73 == io_instruction_id ? 4'hb : 4'ha; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 65:6]
  wire [3:0] _io_csr_bundle_mcause_write_data_T_3 = 32'h100073 == io_instruction_id ? 4'h3 :
    _io_csr_bundle_mcause_write_data_T_1; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 65:6]
  wire [31:0] _io_csr_bundle_mcause_write_data_T_5 = io_interrupt_flag[0] ? 32'h80000007 : 32'h8000000b; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 77:45]
  wire  _T_6 = io_instruction_id == 32'h30200073; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 81:32]
  wire [31:0] _GEN_0 = io_instruction_id == 32'h30200073 ? mstatus_recover_interrupt : io_csr_bundle_mstatus; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 81:58 82:39 89:39]
  wire [31:0] _GEN_4 = io_instruction_id == 32'h30200073 ? io_csr_bundle_mepc : 32'h0; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 81:58 87:39 94:39]
  wire [31:0] _GEN_5 = io_interrupt_flag != 32'h0 & interrupt_enable_global & interrupt_source_enabled ?
    mstatus_disable_interrupt : _GEN_0; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 74:113 75:39]
  wire [31:0] _GEN_6 = io_interrupt_flag != 32'h0 & interrupt_enable_global & interrupt_source_enabled ?
    instruction_address : io_csr_bundle_mepc; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 74:113 76:39]
  wire [31:0] _GEN_7 = io_interrupt_flag != 32'h0 & interrupt_enable_global & interrupt_source_enabled ?
    _io_csr_bundle_mcause_write_data_T_5 : io_csr_bundle_mcause; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 74:113 77:39]
  wire  _GEN_8 = io_interrupt_flag != 32'h0 & interrupt_enable_global & interrupt_source_enabled | _T_6; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 74:113 78:39]
  wire [31:0] _GEN_9 = io_interrupt_flag != 32'h0 & interrupt_enable_global & interrupt_source_enabled ?
    io_csr_bundle_mtvec : _GEN_4; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 74:113 80:39]
  assign io_id_interrupt_handler_address = io_instruction_id == 32'h73 | io_instruction_id == 32'h100073 ?
    io_csr_bundle_mtvec : _GEN_9; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 59:101 73:39]
  assign io_id_interrupt_assert = io_instruction_id == 32'h73 | io_instruction_id == 32'h100073 | _GEN_8; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 59:101 71:39]
  assign io_csr_bundle_mstatus_write_data = io_instruction_id == 32'h73 | io_instruction_id == 32'h100073 ?
    mstatus_disable_interrupt : _GEN_5; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 59:101 60:38]
  assign io_csr_bundle_mepc_write_data = io_instruction_id == 32'h73 | io_instruction_id == 32'h100073 ?
    instruction_address : _GEN_6; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 59:101 61:38]
  assign io_csr_bundle_mcause_write_data = io_instruction_id == 32'h73 | io_instruction_id == 32'h100073 ? {{28'd0},
    _io_csr_bundle_mcause_write_data_T_3} : _GEN_7; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 59:101 62:37]
  assign io_csr_bundle_direct_write_enable = io_instruction_id == 32'h73 | io_instruction_id == 32'h100073 | _GEN_8; // @[4-soc/src/main/scala/riscv/core/CLINT.scala 59:101 71:39]
endmodule
module CSR(
  input         clock,
  input         reset,
  input  [11:0] io_reg_read_address_id, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input         io_reg_write_enable_ex, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input  [11:0] io_reg_write_address_ex, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input  [31:0] io_reg_write_data_ex, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input  [11:0] io_debug_reg_read_address, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  output [31:0] io_id_reg_read_data, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  output [31:0] io_debug_reg_read_data, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  output [31:0] io_clint_access_bundle_mstatus, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  output [31:0] io_clint_access_bundle_mepc, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  output [31:0] io_clint_access_bundle_mcause, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  output [31:0] io_clint_access_bundle_mtvec, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  output [31:0] io_clint_access_bundle_mie, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input  [31:0] io_clint_access_bundle_mstatus_write_data, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input  [31:0] io_clint_access_bundle_mepc_write_data, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input  [31:0] io_clint_access_bundle_mcause_write_data, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input         io_clint_access_bundle_direct_write_enable, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input         io_instruction_retired, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input         io_branch_misprediction, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input         io_hazard_stall, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input         io_memory_stall, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input         io_control_stall, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input         io_btb_miss_taken, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input         io_branch_resolved, // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
  input         io_btb_predicted // @[4-soc/src/main/scala/riscv/core/CSR.scala 133:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mstatus; // @[4-soc/src/main/scala/riscv/core/CSR.scala 157:25]
  reg [31:0] mie; // @[4-soc/src/main/scala/riscv/core/CSR.scala 158:25]
  reg [31:0] mtvec; // @[4-soc/src/main/scala/riscv/core/CSR.scala 159:25]
  reg [31:0] mscratch; // @[4-soc/src/main/scala/riscv/core/CSR.scala 160:25]
  reg [31:0] mepc; // @[4-soc/src/main/scala/riscv/core/CSR.scala 161:25]
  reg [31:0] mcause; // @[4-soc/src/main/scala/riscv/core/CSR.scala 162:25]
  reg [31:0] mcountinhibit; // @[4-soc/src/main/scala/riscv/core/CSR.scala 167:30]
  reg [63:0] mcycle; // @[4-soc/src/main/scala/riscv/core/CSR.scala 170:29]
  reg [63:0] minstret; // @[4-soc/src/main/scala/riscv/core/CSR.scala 171:29]
  reg [63:0] mhpmcounter3; // @[4-soc/src/main/scala/riscv/core/CSR.scala 172:29]
  reg [63:0] mhpmcounter4; // @[4-soc/src/main/scala/riscv/core/CSR.scala 173:29]
  reg [63:0] mhpmcounter5; // @[4-soc/src/main/scala/riscv/core/CSR.scala 174:29]
  reg [63:0] mhpmcounter6; // @[4-soc/src/main/scala/riscv/core/CSR.scala 175:29]
  reg [63:0] mhpmcounter7; // @[4-soc/src/main/scala/riscv/core/CSR.scala 176:29]
  reg [63:0] mhpmcounter8; // @[4-soc/src/main/scala/riscv/core/CSR.scala 177:29]
  reg [63:0] mhpmcounter9; // @[4-soc/src/main/scala/riscv/core/CSR.scala 178:29]
  reg [31:0] mcycle_shadow; // @[4-soc/src/main/scala/riscv/core/CSR.scala 184:36]
  reg [31:0] minstret_shadow; // @[4-soc/src/main/scala/riscv/core/CSR.scala 185:36]
  reg [31:0] mhpmcounter3_shadow; // @[4-soc/src/main/scala/riscv/core/CSR.scala 186:36]
  reg [31:0] mhpmcounter4_shadow; // @[4-soc/src/main/scala/riscv/core/CSR.scala 187:36]
  reg [31:0] mhpmcounter5_shadow; // @[4-soc/src/main/scala/riscv/core/CSR.scala 188:36]
  reg [31:0] mhpmcounter6_shadow; // @[4-soc/src/main/scala/riscv/core/CSR.scala 189:36]
  reg [31:0] mhpmcounter7_shadow; // @[4-soc/src/main/scala/riscv/core/CSR.scala 190:36]
  reg [31:0] mhpmcounter8_shadow; // @[4-soc/src/main/scala/riscv/core/CSR.scala 191:36]
  reg [31:0] mhpmcounter9_shadow; // @[4-soc/src/main/scala/riscv/core/CSR.scala 192:36]
  wire  reading_cycle_low = io_reg_read_address_id == 12'hc00 | io_reg_read_address_id == 12'hb00; // @[4-soc/src/main/scala/riscv/core/CSR.scala 196:51]
  wire  reading_instret_low = io_reg_read_address_id == 12'hc02 | io_reg_read_address_id == 12'hb02; // @[4-soc/src/main/scala/riscv/core/CSR.scala 198:53]
  wire  reading_hpm3_low = io_reg_read_address_id == 12'hb03; // @[4-soc/src/main/scala/riscv/core/CSR.scala 199:49]
  wire  reading_hpm4_low = io_reg_read_address_id == 12'hb04; // @[4-soc/src/main/scala/riscv/core/CSR.scala 200:49]
  wire  reading_hpm5_low = io_reg_read_address_id == 12'hb05; // @[4-soc/src/main/scala/riscv/core/CSR.scala 201:49]
  wire  reading_hpm6_low = io_reg_read_address_id == 12'hb06; // @[4-soc/src/main/scala/riscv/core/CSR.scala 202:49]
  wire  reading_hpm7_low = io_reg_read_address_id == 12'hb07; // @[4-soc/src/main/scala/riscv/core/CSR.scala 203:49]
  wire  reading_hpm8_low = io_reg_read_address_id == 12'hb08; // @[4-soc/src/main/scala/riscv/core/CSR.scala 204:49]
  wire  reading_hpm9_low = io_reg_read_address_id == 12'hb09; // @[4-soc/src/main/scala/riscv/core/CSR.scala 205:49]
  wire  inhibit_cy = mcountinhibit[0]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 236:35]
  wire  inhibit_ir = mcountinhibit[2]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 237:35]
  wire  inhibit_hpm3 = mcountinhibit[3]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 238:35]
  wire  inhibit_hpm4 = mcountinhibit[4]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 239:35]
  wire  inhibit_hpm5 = mcountinhibit[5]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 240:35]
  wire  inhibit_hpm6 = mcountinhibit[6]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 241:35]
  wire  inhibit_hpm7 = mcountinhibit[7]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 242:35]
  wire  inhibit_hpm8 = mcountinhibit[8]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 243:35]
  wire  inhibit_hpm9 = mcountinhibit[9]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 244:35]
  wire [63:0] _mcycle_T_1 = mcycle + 64'h1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 249:22]
  wire [63:0] _GEN_9 = ~inhibit_cy ? _mcycle_T_1 : mcycle; // @[4-soc/src/main/scala/riscv/core/CSR.scala 248:21 249:12 170:29]
  wire [63:0] _minstret_T_1 = minstret + 64'h1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 252:26]
  wire [63:0] _GEN_10 = io_instruction_retired & ~inhibit_ir ? _minstret_T_1 : minstret; // @[4-soc/src/main/scala/riscv/core/CSR.scala 251:47 252:14 171:29]
  wire [63:0] _mhpmcounter3_T_1 = mhpmcounter3 + 64'h1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 255:34]
  wire [63:0] _GEN_11 = io_branch_misprediction & ~inhibit_hpm3 ? _mhpmcounter3_T_1 : mhpmcounter3; // @[4-soc/src/main/scala/riscv/core/CSR.scala 254:50 255:18 172:29]
  wire [63:0] _mhpmcounter4_T_1 = mhpmcounter4 + 64'h1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 258:34]
  wire [63:0] _GEN_12 = io_hazard_stall & ~inhibit_hpm4 ? _mhpmcounter4_T_1 : mhpmcounter4; // @[4-soc/src/main/scala/riscv/core/CSR.scala 257:42 258:18 173:29]
  wire [63:0] _mhpmcounter5_T_1 = mhpmcounter5 + 64'h1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 261:34]
  wire [63:0] _GEN_13 = io_memory_stall & ~inhibit_hpm5 ? _mhpmcounter5_T_1 : mhpmcounter5; // @[4-soc/src/main/scala/riscv/core/CSR.scala 260:42 261:18 174:29]
  wire [63:0] _mhpmcounter6_T_1 = mhpmcounter6 + 64'h1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 264:34]
  wire [63:0] _GEN_14 = io_control_stall & ~inhibit_hpm6 ? _mhpmcounter6_T_1 : mhpmcounter6; // @[4-soc/src/main/scala/riscv/core/CSR.scala 263:43 264:18 175:29]
  wire [63:0] _mhpmcounter7_T_1 = mhpmcounter7 + 64'h1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 267:34]
  wire [63:0] _GEN_15 = io_btb_miss_taken & ~inhibit_hpm7 ? _mhpmcounter7_T_1 : mhpmcounter7; // @[4-soc/src/main/scala/riscv/core/CSR.scala 266:44 267:18 176:29]
  wire [63:0] _mhpmcounter8_T_1 = mhpmcounter8 + 64'h1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 270:34]
  wire [63:0] _GEN_16 = io_branch_resolved & ~inhibit_hpm8 ? _mhpmcounter8_T_1 : mhpmcounter8; // @[4-soc/src/main/scala/riscv/core/CSR.scala 269:45 270:18 177:29]
  wire [63:0] _mhpmcounter9_T_1 = mhpmcounter9 + 64'h1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 273:34]
  wire [63:0] _GEN_17 = io_btb_predicted & ~inhibit_hpm9 ? _mhpmcounter9_T_1 : mhpmcounter9; // @[4-soc/src/main/scala/riscv/core/CSR.scala 272:43 273:18 178:29]
  wire [31:0] _io_id_reg_read_data_T_1 = 12'h300 == io_reg_read_address_id ? mstatus : 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_3 = 12'h304 == io_reg_read_address_id ? mie : _io_id_reg_read_data_T_1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_5 = 12'h305 == io_reg_read_address_id ? mtvec : _io_id_reg_read_data_T_3; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_7 = 12'h340 == io_reg_read_address_id ? mscratch : _io_id_reg_read_data_T_5; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_9 = 12'h341 == io_reg_read_address_id ? mepc : _io_id_reg_read_data_T_7; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_11 = 12'h342 == io_reg_read_address_id ? mcause : _io_id_reg_read_data_T_9; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_13 = 12'h320 == io_reg_read_address_id ? mcountinhibit : _io_id_reg_read_data_T_11; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_15 = 12'hc00 == io_reg_read_address_id ? mcycle[31:0] : _io_id_reg_read_data_T_13; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_17 = 12'hc80 == io_reg_read_address_id ? mcycle_shadow : _io_id_reg_read_data_T_15; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_19 = 12'hc02 == io_reg_read_address_id ? minstret[31:0] : _io_id_reg_read_data_T_17
    ; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_21 = 12'hc82 == io_reg_read_address_id ? minstret_shadow :
    _io_id_reg_read_data_T_19; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_23 = 12'hb00 == io_reg_read_address_id ? mcycle[31:0] : _io_id_reg_read_data_T_21; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_25 = 12'hb80 == io_reg_read_address_id ? mcycle_shadow : _io_id_reg_read_data_T_23; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_27 = 12'hb02 == io_reg_read_address_id ? minstret[31:0] : _io_id_reg_read_data_T_25
    ; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_29 = 12'hb82 == io_reg_read_address_id ? minstret_shadow :
    _io_id_reg_read_data_T_27; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_31 = 12'hb03 == io_reg_read_address_id ? mhpmcounter3[31:0] :
    _io_id_reg_read_data_T_29; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_33 = 12'hb83 == io_reg_read_address_id ? mhpmcounter3_shadow :
    _io_id_reg_read_data_T_31; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_35 = 12'hb04 == io_reg_read_address_id ? mhpmcounter4[31:0] :
    _io_id_reg_read_data_T_33; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_37 = 12'hb84 == io_reg_read_address_id ? mhpmcounter4_shadow :
    _io_id_reg_read_data_T_35; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_39 = 12'hb05 == io_reg_read_address_id ? mhpmcounter5[31:0] :
    _io_id_reg_read_data_T_37; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_41 = 12'hb85 == io_reg_read_address_id ? mhpmcounter5_shadow :
    _io_id_reg_read_data_T_39; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_43 = 12'hb06 == io_reg_read_address_id ? mhpmcounter6[31:0] :
    _io_id_reg_read_data_T_41; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_45 = 12'hb86 == io_reg_read_address_id ? mhpmcounter6_shadow :
    _io_id_reg_read_data_T_43; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_47 = 12'hb07 == io_reg_read_address_id ? mhpmcounter7[31:0] :
    _io_id_reg_read_data_T_45; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_49 = 12'hb87 == io_reg_read_address_id ? mhpmcounter7_shadow :
    _io_id_reg_read_data_T_47; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_51 = 12'hb08 == io_reg_read_address_id ? mhpmcounter8[31:0] :
    _io_id_reg_read_data_T_49; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_53 = 12'hb88 == io_reg_read_address_id ? mhpmcounter8_shadow :
    _io_id_reg_read_data_T_51; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_id_reg_read_data_T_55 = 12'hb09 == io_reg_read_address_id ? mhpmcounter9[31:0] :
    _io_id_reg_read_data_T_53; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  wire [31:0] _io_debug_reg_read_data_T_1 = 12'h300 == io_debug_reg_read_address ? mstatus : 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_3 = 12'h304 == io_debug_reg_read_address ? mie : _io_debug_reg_read_data_T_1; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_5 = 12'h305 == io_debug_reg_read_address ? mtvec : _io_debug_reg_read_data_T_3; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_7 = 12'h340 == io_debug_reg_read_address ? mscratch :
    _io_debug_reg_read_data_T_5; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_9 = 12'h341 == io_debug_reg_read_address ? mepc : _io_debug_reg_read_data_T_7; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_11 = 12'h342 == io_debug_reg_read_address ? mcause : _io_debug_reg_read_data_T_9
    ; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_13 = 12'h320 == io_debug_reg_read_address ? mcountinhibit :
    _io_debug_reg_read_data_T_11; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_15 = 12'hc00 == io_debug_reg_read_address ? mcycle[31:0] :
    _io_debug_reg_read_data_T_13; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_17 = 12'hc80 == io_debug_reg_read_address ? mcycle_shadow :
    _io_debug_reg_read_data_T_15; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_19 = 12'hc02 == io_debug_reg_read_address ? minstret[31:0] :
    _io_debug_reg_read_data_T_17; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_21 = 12'hc82 == io_debug_reg_read_address ? minstret_shadow :
    _io_debug_reg_read_data_T_19; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_23 = 12'hb00 == io_debug_reg_read_address ? mcycle[31:0] :
    _io_debug_reg_read_data_T_21; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_25 = 12'hb80 == io_debug_reg_read_address ? mcycle_shadow :
    _io_debug_reg_read_data_T_23; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_27 = 12'hb02 == io_debug_reg_read_address ? minstret[31:0] :
    _io_debug_reg_read_data_T_25; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_29 = 12'hb82 == io_debug_reg_read_address ? minstret_shadow :
    _io_debug_reg_read_data_T_27; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_31 = 12'hb03 == io_debug_reg_read_address ? mhpmcounter3[31:0] :
    _io_debug_reg_read_data_T_29; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_33 = 12'hb83 == io_debug_reg_read_address ? mhpmcounter3_shadow :
    _io_debug_reg_read_data_T_31; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_35 = 12'hb04 == io_debug_reg_read_address ? mhpmcounter4[31:0] :
    _io_debug_reg_read_data_T_33; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_37 = 12'hb84 == io_debug_reg_read_address ? mhpmcounter4_shadow :
    _io_debug_reg_read_data_T_35; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_39 = 12'hb05 == io_debug_reg_read_address ? mhpmcounter5[31:0] :
    _io_debug_reg_read_data_T_37; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_41 = 12'hb85 == io_debug_reg_read_address ? mhpmcounter5_shadow :
    _io_debug_reg_read_data_T_39; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_43 = 12'hb06 == io_debug_reg_read_address ? mhpmcounter6[31:0] :
    _io_debug_reg_read_data_T_41; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_45 = 12'hb86 == io_debug_reg_read_address ? mhpmcounter6_shadow :
    _io_debug_reg_read_data_T_43; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_47 = 12'hb07 == io_debug_reg_read_address ? mhpmcounter7[31:0] :
    _io_debug_reg_read_data_T_45; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_49 = 12'hb87 == io_debug_reg_read_address ? mhpmcounter7_shadow :
    _io_debug_reg_read_data_T_47; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_51 = 12'hb08 == io_debug_reg_read_address ? mhpmcounter8[31:0] :
    _io_debug_reg_read_data_T_49; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_53 = 12'hb88 == io_debug_reg_read_address ? mhpmcounter8_shadow :
    _io_debug_reg_read_data_T_51; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire [31:0] _io_debug_reg_read_data_T_55 = 12'hb09 == io_debug_reg_read_address ? mhpmcounter9[31:0] :
    _io_debug_reg_read_data_T_53; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  wire  _io_clint_access_bundle_mstatus_T = io_reg_write_address_ex == 12'h300; // @[4-soc/src/main/scala/riscv/core/CSR.scala 323:55]
  wire  _io_clint_access_bundle_mstatus_T_1 = io_reg_write_enable_ex & io_reg_write_address_ex == 12'h300; // @[4-soc/src/main/scala/riscv/core/CSR.scala 323:28]
  wire  _io_clint_access_bundle_mtvec_T = io_reg_write_address_ex == 12'h305; // @[4-soc/src/main/scala/riscv/core/CSR.scala 328:55]
  wire  _io_clint_access_bundle_mtvec_T_1 = io_reg_write_enable_ex & io_reg_write_address_ex == 12'h305; // @[4-soc/src/main/scala/riscv/core/CSR.scala 328:28]
  wire  _io_clint_access_bundle_mcause_T = io_reg_write_address_ex == 12'h342; // @[4-soc/src/main/scala/riscv/core/CSR.scala 333:55]
  wire  _io_clint_access_bundle_mcause_T_1 = io_reg_write_enable_ex & io_reg_write_address_ex == 12'h342; // @[4-soc/src/main/scala/riscv/core/CSR.scala 333:28]
  wire  _io_clint_access_bundle_mepc_T = io_reg_write_address_ex == 12'h341; // @[4-soc/src/main/scala/riscv/core/CSR.scala 338:55]
  wire  _io_clint_access_bundle_mepc_T_1 = io_reg_write_enable_ex & io_reg_write_address_ex == 12'h341; // @[4-soc/src/main/scala/riscv/core/CSR.scala 338:28]
  wire  _io_clint_access_bundle_mie_T = io_reg_write_address_ex == 12'h304; // @[4-soc/src/main/scala/riscv/core/CSR.scala 343:55]
  wire  _io_clint_access_bundle_mie_T_1 = io_reg_write_enable_ex & io_reg_write_address_ex == 12'h304; // @[4-soc/src/main/scala/riscv/core/CSR.scala 343:28]
  wire [31:0] _GEN_18 = _io_clint_access_bundle_mcause_T ? io_reg_write_data_ex : mcause; // @[4-soc/src/main/scala/riscv/core/CSR.scala 357:64 358:14 162:25]
  wire [31:0] _GEN_19 = _io_clint_access_bundle_mepc_T ? io_reg_write_data_ex : mepc; // @[4-soc/src/main/scala/riscv/core/CSR.scala 355:62 356:12 161:25]
  wire [31:0] _GEN_20 = _io_clint_access_bundle_mepc_T ? mcause : _GEN_18; // @[4-soc/src/main/scala/riscv/core/CSR.scala 162:25 355:62]
  wire [31:0] _mcountinhibit_T = io_reg_write_data_ex & 32'h3fd; // @[4-soc/src/main/scala/riscv/core/CSR.scala 372:45]
  wire [31:0] _GEN_30 = io_reg_write_address_ex == 12'h320 ? _mcountinhibit_T : mcountinhibit; // @[4-soc/src/main/scala/riscv/core/CSR.scala 369:71 372:21 167:30]
  wire [31:0] _GEN_31 = io_reg_write_address_ex == 12'h340 ? io_reg_write_data_ex : mscratch; // @[4-soc/src/main/scala/riscv/core/CSR.scala 367:66 368:16 160:25]
  wire [31:0] _GEN_32 = io_reg_write_address_ex == 12'h340 ? mcountinhibit : _GEN_30; // @[4-soc/src/main/scala/riscv/core/CSR.scala 167:30 367:66]
  wire [63:0] _mcycle_T_3 = {mcycle[63:32],io_reg_write_data_ex}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 381:20]
  wire [63:0] _mcycle_T_5 = {io_reg_write_data_ex,mcycle[31:0]}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 383:20]
  wire [63:0] _minstret_T_3 = {minstret[63:32],io_reg_write_data_ex}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 385:22]
  wire [63:0] _minstret_T_5 = {io_reg_write_data_ex,minstret[31:0]}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 387:22]
  wire [63:0] _mhpmcounter3_T_3 = {mhpmcounter3[63:32],io_reg_write_data_ex}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 389:26]
  wire [63:0] _mhpmcounter3_T_5 = {io_reg_write_data_ex,mhpmcounter3[31:0]}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 391:26]
  wire [63:0] _mhpmcounter4_T_3 = {mhpmcounter4[63:32],io_reg_write_data_ex}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 393:26]
  wire [63:0] _mhpmcounter4_T_5 = {io_reg_write_data_ex,mhpmcounter4[31:0]}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 395:26]
  wire [63:0] _mhpmcounter5_T_3 = {mhpmcounter5[63:32],io_reg_write_data_ex}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 397:26]
  wire [63:0] _mhpmcounter5_T_5 = {io_reg_write_data_ex,mhpmcounter5[31:0]}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 399:26]
  wire [63:0] _mhpmcounter6_T_3 = {mhpmcounter6[63:32],io_reg_write_data_ex}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 401:26]
  wire [63:0] _mhpmcounter6_T_5 = {io_reg_write_data_ex,mhpmcounter6[31:0]}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 403:26]
  wire [63:0] _mhpmcounter7_T_3 = {mhpmcounter7[63:32],io_reg_write_data_ex}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 405:26]
  wire [63:0] _mhpmcounter7_T_5 = {io_reg_write_data_ex,mhpmcounter7[31:0]}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 407:26]
  wire [63:0] _mhpmcounter8_T_3 = {mhpmcounter8[63:32],io_reg_write_data_ex}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 409:26]
  wire [63:0] _mhpmcounter8_T_5 = {io_reg_write_data_ex,mhpmcounter8[31:0]}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 411:26]
  wire [63:0] _mhpmcounter9_T_3 = {mhpmcounter9[63:32],io_reg_write_data_ex}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 413:26]
  wire [63:0] _mhpmcounter9_T_5 = {io_reg_write_data_ex,mhpmcounter9[31:0]}; // @[4-soc/src/main/scala/riscv/core/CSR.scala 415:26]
  wire [63:0] _GEN_44 = io_reg_write_address_ex == 12'hb89 ? _mhpmcounter9_T_5 : _GEN_17; // @[4-soc/src/main/scala/riscv/core/CSR.scala 414:71 415:20]
  wire [63:0] _GEN_45 = io_reg_write_address_ex == 12'hb09 ? _mhpmcounter9_T_3 : _GEN_44; // @[4-soc/src/main/scala/riscv/core/CSR.scala 412:71 413:20]
  wire [63:0] _GEN_46 = io_reg_write_address_ex == 12'hb88 ? _mhpmcounter8_T_5 : _GEN_16; // @[4-soc/src/main/scala/riscv/core/CSR.scala 410:71 411:20]
  wire [63:0] _GEN_47 = io_reg_write_address_ex == 12'hb88 ? _GEN_17 : _GEN_45; // @[4-soc/src/main/scala/riscv/core/CSR.scala 410:71]
  wire [63:0] _GEN_48 = io_reg_write_address_ex == 12'hb08 ? _mhpmcounter8_T_3 : _GEN_46; // @[4-soc/src/main/scala/riscv/core/CSR.scala 408:71 409:20]
  wire [63:0] _GEN_49 = io_reg_write_address_ex == 12'hb08 ? _GEN_17 : _GEN_47; // @[4-soc/src/main/scala/riscv/core/CSR.scala 408:71]
  wire [63:0] _GEN_50 = io_reg_write_address_ex == 12'hb87 ? _mhpmcounter7_T_5 : _GEN_15; // @[4-soc/src/main/scala/riscv/core/CSR.scala 406:71 407:20]
  wire [63:0] _GEN_51 = io_reg_write_address_ex == 12'hb87 ? _GEN_16 : _GEN_48; // @[4-soc/src/main/scala/riscv/core/CSR.scala 406:71]
  wire [63:0] _GEN_52 = io_reg_write_address_ex == 12'hb87 ? _GEN_17 : _GEN_49; // @[4-soc/src/main/scala/riscv/core/CSR.scala 406:71]
  wire [63:0] _GEN_53 = io_reg_write_address_ex == 12'hb07 ? _mhpmcounter7_T_3 : _GEN_50; // @[4-soc/src/main/scala/riscv/core/CSR.scala 404:71 405:20]
  wire [63:0] _GEN_54 = io_reg_write_address_ex == 12'hb07 ? _GEN_16 : _GEN_51; // @[4-soc/src/main/scala/riscv/core/CSR.scala 404:71]
  wire [63:0] _GEN_55 = io_reg_write_address_ex == 12'hb07 ? _GEN_17 : _GEN_52; // @[4-soc/src/main/scala/riscv/core/CSR.scala 404:71]
  wire [63:0] _GEN_56 = io_reg_write_address_ex == 12'hb86 ? _mhpmcounter6_T_5 : _GEN_14; // @[4-soc/src/main/scala/riscv/core/CSR.scala 402:71 403:20]
  wire [63:0] _GEN_57 = io_reg_write_address_ex == 12'hb86 ? _GEN_15 : _GEN_53; // @[4-soc/src/main/scala/riscv/core/CSR.scala 402:71]
  wire [63:0] _GEN_58 = io_reg_write_address_ex == 12'hb86 ? _GEN_16 : _GEN_54; // @[4-soc/src/main/scala/riscv/core/CSR.scala 402:71]
  wire [63:0] _GEN_59 = io_reg_write_address_ex == 12'hb86 ? _GEN_17 : _GEN_55; // @[4-soc/src/main/scala/riscv/core/CSR.scala 402:71]
  wire [63:0] _GEN_60 = io_reg_write_address_ex == 12'hb06 ? _mhpmcounter6_T_3 : _GEN_56; // @[4-soc/src/main/scala/riscv/core/CSR.scala 400:71 401:20]
  wire [63:0] _GEN_61 = io_reg_write_address_ex == 12'hb06 ? _GEN_15 : _GEN_57; // @[4-soc/src/main/scala/riscv/core/CSR.scala 400:71]
  wire [63:0] _GEN_62 = io_reg_write_address_ex == 12'hb06 ? _GEN_16 : _GEN_58; // @[4-soc/src/main/scala/riscv/core/CSR.scala 400:71]
  wire [63:0] _GEN_63 = io_reg_write_address_ex == 12'hb06 ? _GEN_17 : _GEN_59; // @[4-soc/src/main/scala/riscv/core/CSR.scala 400:71]
  wire [63:0] _GEN_64 = io_reg_write_address_ex == 12'hb85 ? _mhpmcounter5_T_5 : _GEN_13; // @[4-soc/src/main/scala/riscv/core/CSR.scala 398:71 399:20]
  wire [63:0] _GEN_65 = io_reg_write_address_ex == 12'hb85 ? _GEN_14 : _GEN_60; // @[4-soc/src/main/scala/riscv/core/CSR.scala 398:71]
  wire [63:0] _GEN_66 = io_reg_write_address_ex == 12'hb85 ? _GEN_15 : _GEN_61; // @[4-soc/src/main/scala/riscv/core/CSR.scala 398:71]
  wire [63:0] _GEN_67 = io_reg_write_address_ex == 12'hb85 ? _GEN_16 : _GEN_62; // @[4-soc/src/main/scala/riscv/core/CSR.scala 398:71]
  wire [63:0] _GEN_68 = io_reg_write_address_ex == 12'hb85 ? _GEN_17 : _GEN_63; // @[4-soc/src/main/scala/riscv/core/CSR.scala 398:71]
  wire [63:0] _GEN_69 = io_reg_write_address_ex == 12'hb05 ? _mhpmcounter5_T_3 : _GEN_64; // @[4-soc/src/main/scala/riscv/core/CSR.scala 396:71 397:20]
  wire [63:0] _GEN_70 = io_reg_write_address_ex == 12'hb05 ? _GEN_14 : _GEN_65; // @[4-soc/src/main/scala/riscv/core/CSR.scala 396:71]
  wire [63:0] _GEN_71 = io_reg_write_address_ex == 12'hb05 ? _GEN_15 : _GEN_66; // @[4-soc/src/main/scala/riscv/core/CSR.scala 396:71]
  wire [63:0] _GEN_72 = io_reg_write_address_ex == 12'hb05 ? _GEN_16 : _GEN_67; // @[4-soc/src/main/scala/riscv/core/CSR.scala 396:71]
  wire [63:0] _GEN_73 = io_reg_write_address_ex == 12'hb05 ? _GEN_17 : _GEN_68; // @[4-soc/src/main/scala/riscv/core/CSR.scala 396:71]
  wire [63:0] _GEN_74 = io_reg_write_address_ex == 12'hb84 ? _mhpmcounter4_T_5 : _GEN_12; // @[4-soc/src/main/scala/riscv/core/CSR.scala 394:71 395:20]
  wire [63:0] _GEN_75 = io_reg_write_address_ex == 12'hb84 ? _GEN_13 : _GEN_69; // @[4-soc/src/main/scala/riscv/core/CSR.scala 394:71]
  wire [63:0] _GEN_76 = io_reg_write_address_ex == 12'hb84 ? _GEN_14 : _GEN_70; // @[4-soc/src/main/scala/riscv/core/CSR.scala 394:71]
  wire [63:0] _GEN_77 = io_reg_write_address_ex == 12'hb84 ? _GEN_15 : _GEN_71; // @[4-soc/src/main/scala/riscv/core/CSR.scala 394:71]
  wire [63:0] _GEN_78 = io_reg_write_address_ex == 12'hb84 ? _GEN_16 : _GEN_72; // @[4-soc/src/main/scala/riscv/core/CSR.scala 394:71]
  wire [63:0] _GEN_79 = io_reg_write_address_ex == 12'hb84 ? _GEN_17 : _GEN_73; // @[4-soc/src/main/scala/riscv/core/CSR.scala 394:71]
  wire [63:0] _GEN_80 = io_reg_write_address_ex == 12'hb04 ? _mhpmcounter4_T_3 : _GEN_74; // @[4-soc/src/main/scala/riscv/core/CSR.scala 392:71 393:20]
  wire [63:0] _GEN_81 = io_reg_write_address_ex == 12'hb04 ? _GEN_13 : _GEN_75; // @[4-soc/src/main/scala/riscv/core/CSR.scala 392:71]
  wire [63:0] _GEN_82 = io_reg_write_address_ex == 12'hb04 ? _GEN_14 : _GEN_76; // @[4-soc/src/main/scala/riscv/core/CSR.scala 392:71]
  wire [63:0] _GEN_83 = io_reg_write_address_ex == 12'hb04 ? _GEN_15 : _GEN_77; // @[4-soc/src/main/scala/riscv/core/CSR.scala 392:71]
  wire [63:0] _GEN_84 = io_reg_write_address_ex == 12'hb04 ? _GEN_16 : _GEN_78; // @[4-soc/src/main/scala/riscv/core/CSR.scala 392:71]
  wire [63:0] _GEN_85 = io_reg_write_address_ex == 12'hb04 ? _GEN_17 : _GEN_79; // @[4-soc/src/main/scala/riscv/core/CSR.scala 392:71]
  wire [63:0] _GEN_86 = io_reg_write_address_ex == 12'hb83 ? _mhpmcounter3_T_5 : _GEN_11; // @[4-soc/src/main/scala/riscv/core/CSR.scala 390:71 391:20]
  wire [63:0] _GEN_87 = io_reg_write_address_ex == 12'hb83 ? _GEN_12 : _GEN_80; // @[4-soc/src/main/scala/riscv/core/CSR.scala 390:71]
  wire [63:0] _GEN_88 = io_reg_write_address_ex == 12'hb83 ? _GEN_13 : _GEN_81; // @[4-soc/src/main/scala/riscv/core/CSR.scala 390:71]
  wire [63:0] _GEN_89 = io_reg_write_address_ex == 12'hb83 ? _GEN_14 : _GEN_82; // @[4-soc/src/main/scala/riscv/core/CSR.scala 390:71]
  wire [63:0] _GEN_90 = io_reg_write_address_ex == 12'hb83 ? _GEN_15 : _GEN_83; // @[4-soc/src/main/scala/riscv/core/CSR.scala 390:71]
  wire [63:0] _GEN_91 = io_reg_write_address_ex == 12'hb83 ? _GEN_16 : _GEN_84; // @[4-soc/src/main/scala/riscv/core/CSR.scala 390:71]
  wire [63:0] _GEN_92 = io_reg_write_address_ex == 12'hb83 ? _GEN_17 : _GEN_85; // @[4-soc/src/main/scala/riscv/core/CSR.scala 390:71]
  wire [63:0] _GEN_93 = io_reg_write_address_ex == 12'hb03 ? _mhpmcounter3_T_3 : _GEN_86; // @[4-soc/src/main/scala/riscv/core/CSR.scala 388:71 389:20]
  wire [63:0] _GEN_94 = io_reg_write_address_ex == 12'hb03 ? _GEN_12 : _GEN_87; // @[4-soc/src/main/scala/riscv/core/CSR.scala 388:71]
  wire [63:0] _GEN_95 = io_reg_write_address_ex == 12'hb03 ? _GEN_13 : _GEN_88; // @[4-soc/src/main/scala/riscv/core/CSR.scala 388:71]
  wire [63:0] _GEN_96 = io_reg_write_address_ex == 12'hb03 ? _GEN_14 : _GEN_89; // @[4-soc/src/main/scala/riscv/core/CSR.scala 388:71]
  wire [63:0] _GEN_97 = io_reg_write_address_ex == 12'hb03 ? _GEN_15 : _GEN_90; // @[4-soc/src/main/scala/riscv/core/CSR.scala 388:71]
  wire [63:0] _GEN_98 = io_reg_write_address_ex == 12'hb03 ? _GEN_16 : _GEN_91; // @[4-soc/src/main/scala/riscv/core/CSR.scala 388:71]
  wire [63:0] _GEN_99 = io_reg_write_address_ex == 12'hb03 ? _GEN_17 : _GEN_92; // @[4-soc/src/main/scala/riscv/core/CSR.scala 388:71]
  wire [63:0] _GEN_100 = io_reg_write_address_ex == 12'hb82 ? _minstret_T_5 : _GEN_10; // @[4-soc/src/main/scala/riscv/core/CSR.scala 386:67 387:16]
  wire [63:0] _GEN_101 = io_reg_write_address_ex == 12'hb82 ? _GEN_11 : _GEN_93; // @[4-soc/src/main/scala/riscv/core/CSR.scala 386:67]
  wire [63:0] _GEN_102 = io_reg_write_address_ex == 12'hb82 ? _GEN_12 : _GEN_94; // @[4-soc/src/main/scala/riscv/core/CSR.scala 386:67]
  wire [63:0] _GEN_103 = io_reg_write_address_ex == 12'hb82 ? _GEN_13 : _GEN_95; // @[4-soc/src/main/scala/riscv/core/CSR.scala 386:67]
  wire [63:0] _GEN_104 = io_reg_write_address_ex == 12'hb82 ? _GEN_14 : _GEN_96; // @[4-soc/src/main/scala/riscv/core/CSR.scala 386:67]
  wire [63:0] _GEN_105 = io_reg_write_address_ex == 12'hb82 ? _GEN_15 : _GEN_97; // @[4-soc/src/main/scala/riscv/core/CSR.scala 386:67]
  wire [63:0] _GEN_106 = io_reg_write_address_ex == 12'hb82 ? _GEN_16 : _GEN_98; // @[4-soc/src/main/scala/riscv/core/CSR.scala 386:67]
  wire [63:0] _GEN_107 = io_reg_write_address_ex == 12'hb82 ? _GEN_17 : _GEN_99; // @[4-soc/src/main/scala/riscv/core/CSR.scala 386:67]
  wire [63:0] _GEN_108 = io_reg_write_address_ex == 12'hb02 ? _minstret_T_3 : _GEN_100; // @[4-soc/src/main/scala/riscv/core/CSR.scala 384:67 385:16]
  wire [63:0] _GEN_109 = io_reg_write_address_ex == 12'hb02 ? _GEN_11 : _GEN_101; // @[4-soc/src/main/scala/riscv/core/CSR.scala 384:67]
  wire [63:0] _GEN_110 = io_reg_write_address_ex == 12'hb02 ? _GEN_12 : _GEN_102; // @[4-soc/src/main/scala/riscv/core/CSR.scala 384:67]
  wire [63:0] _GEN_111 = io_reg_write_address_ex == 12'hb02 ? _GEN_13 : _GEN_103; // @[4-soc/src/main/scala/riscv/core/CSR.scala 384:67]
  wire [63:0] _GEN_112 = io_reg_write_address_ex == 12'hb02 ? _GEN_14 : _GEN_104; // @[4-soc/src/main/scala/riscv/core/CSR.scala 384:67]
  wire [63:0] _GEN_113 = io_reg_write_address_ex == 12'hb02 ? _GEN_15 : _GEN_105; // @[4-soc/src/main/scala/riscv/core/CSR.scala 384:67]
  wire [63:0] _GEN_114 = io_reg_write_address_ex == 12'hb02 ? _GEN_16 : _GEN_106; // @[4-soc/src/main/scala/riscv/core/CSR.scala 384:67]
  wire [63:0] _GEN_115 = io_reg_write_address_ex == 12'hb02 ? _GEN_17 : _GEN_107; // @[4-soc/src/main/scala/riscv/core/CSR.scala 384:67]
  assign io_id_reg_read_data = 12'hb89 == io_reg_read_address_id ? mhpmcounter9_shadow : _io_id_reg_read_data_T_55; // @[4-soc/src/main/scala/riscv/core/CSR.scala 319:67]
  assign io_debug_reg_read_data = 12'hb89 == io_debug_reg_read_address ? mhpmcounter9_shadow :
    _io_debug_reg_read_data_T_55; // @[4-soc/src/main/scala/riscv/core/CSR.scala 320:70]
  assign io_clint_access_bundle_mstatus = _io_clint_access_bundle_mstatus_T_1 ? io_reg_write_data_ex : mstatus; // @[4-soc/src/main/scala/riscv/core/CSR.scala 322:40]
  assign io_clint_access_bundle_mepc = _io_clint_access_bundle_mepc_T_1 ? io_reg_write_data_ex : mepc; // @[4-soc/src/main/scala/riscv/core/CSR.scala 337:37]
  assign io_clint_access_bundle_mcause = _io_clint_access_bundle_mcause_T_1 ? io_reg_write_data_ex : mcause; // @[4-soc/src/main/scala/riscv/core/CSR.scala 332:39]
  assign io_clint_access_bundle_mtvec = _io_clint_access_bundle_mtvec_T_1 ? io_reg_write_data_ex : mtvec; // @[4-soc/src/main/scala/riscv/core/CSR.scala 327:38]
  assign io_clint_access_bundle_mie = _io_clint_access_bundle_mie_T_1 ? io_reg_write_data_ex : mie; // @[4-soc/src/main/scala/riscv/core/CSR.scala 342:36]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 157:25]
      mstatus <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 157:25]
    end else if (io_clint_access_bundle_direct_write_enable) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 348:52]
      mstatus <= io_clint_access_bundle_mstatus_write_data; // @[4-soc/src/main/scala/riscv/core/CSR.scala 349:13]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 352:38]
      if (_io_clint_access_bundle_mstatus_T) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 353:59]
        mstatus <= io_reg_write_data_ex; // @[4-soc/src/main/scala/riscv/core/CSR.scala 354:15]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 158:25]
      mie <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 158:25]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 362:32]
      if (_io_clint_access_bundle_mie_T) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 363:55]
        mie <= io_reg_write_data_ex; // @[4-soc/src/main/scala/riscv/core/CSR.scala 364:11]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 159:25]
      mtvec <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 159:25]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 362:32]
      if (!(_io_clint_access_bundle_mie_T)) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 363:55]
        if (_io_clint_access_bundle_mtvec_T) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 365:63]
          mtvec <= io_reg_write_data_ex; // @[4-soc/src/main/scala/riscv/core/CSR.scala 366:13]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 160:25]
      mscratch <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 160:25]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 362:32]
      if (!(_io_clint_access_bundle_mie_T)) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 363:55]
        if (!(_io_clint_access_bundle_mtvec_T)) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 365:63]
          mscratch <= _GEN_31;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 161:25]
      mepc <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 161:25]
    end else if (io_clint_access_bundle_direct_write_enable) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 348:52]
      mepc <= io_clint_access_bundle_mepc_write_data; // @[4-soc/src/main/scala/riscv/core/CSR.scala 350:13]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 352:38]
      if (!(_io_clint_access_bundle_mstatus_T)) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 353:59]
        mepc <= _GEN_19;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 162:25]
      mcause <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 162:25]
    end else if (io_clint_access_bundle_direct_write_enable) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 348:52]
      mcause <= io_clint_access_bundle_mcause_write_data; // @[4-soc/src/main/scala/riscv/core/CSR.scala 351:13]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 352:38]
      if (!(_io_clint_access_bundle_mstatus_T)) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 353:59]
        mcause <= _GEN_20;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 167:30]
      mcountinhibit <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 167:30]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 362:32]
      if (!(_io_clint_access_bundle_mie_T)) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 363:55]
        if (!(_io_clint_access_bundle_mtvec_T)) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 365:63]
          mcountinhibit <= _GEN_32;
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 170:29]
      mcycle <= 64'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 170:29]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 379:32]
      if (io_reg_write_address_ex == 12'hb00) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 380:59]
        mcycle <= _mcycle_T_3; // @[4-soc/src/main/scala/riscv/core/CSR.scala 381:14]
      end else if (io_reg_write_address_ex == 12'hb80) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 382:65]
        mcycle <= _mcycle_T_5; // @[4-soc/src/main/scala/riscv/core/CSR.scala 383:14]
      end else begin
        mcycle <= _GEN_9;
      end
    end else begin
      mcycle <= _GEN_9;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 171:29]
      minstret <= 64'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 171:29]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 379:32]
      if (io_reg_write_address_ex == 12'hb00) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 380:59]
        minstret <= _GEN_10;
      end else if (io_reg_write_address_ex == 12'hb80) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 382:65]
        minstret <= _GEN_10;
      end else begin
        minstret <= _GEN_108;
      end
    end else begin
      minstret <= _GEN_10;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 172:29]
      mhpmcounter3 <= 64'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 172:29]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 379:32]
      if (io_reg_write_address_ex == 12'hb00) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 380:59]
        mhpmcounter3 <= _GEN_11;
      end else if (io_reg_write_address_ex == 12'hb80) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 382:65]
        mhpmcounter3 <= _GEN_11;
      end else begin
        mhpmcounter3 <= _GEN_109;
      end
    end else begin
      mhpmcounter3 <= _GEN_11;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 173:29]
      mhpmcounter4 <= 64'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 173:29]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 379:32]
      if (io_reg_write_address_ex == 12'hb00) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 380:59]
        mhpmcounter4 <= _GEN_12;
      end else if (io_reg_write_address_ex == 12'hb80) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 382:65]
        mhpmcounter4 <= _GEN_12;
      end else begin
        mhpmcounter4 <= _GEN_110;
      end
    end else begin
      mhpmcounter4 <= _GEN_12;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 174:29]
      mhpmcounter5 <= 64'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 174:29]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 379:32]
      if (io_reg_write_address_ex == 12'hb00) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 380:59]
        mhpmcounter5 <= _GEN_13;
      end else if (io_reg_write_address_ex == 12'hb80) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 382:65]
        mhpmcounter5 <= _GEN_13;
      end else begin
        mhpmcounter5 <= _GEN_111;
      end
    end else begin
      mhpmcounter5 <= _GEN_13;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 175:29]
      mhpmcounter6 <= 64'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 175:29]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 379:32]
      if (io_reg_write_address_ex == 12'hb00) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 380:59]
        mhpmcounter6 <= _GEN_14;
      end else if (io_reg_write_address_ex == 12'hb80) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 382:65]
        mhpmcounter6 <= _GEN_14;
      end else begin
        mhpmcounter6 <= _GEN_112;
      end
    end else begin
      mhpmcounter6 <= _GEN_14;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 176:29]
      mhpmcounter7 <= 64'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 176:29]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 379:32]
      if (io_reg_write_address_ex == 12'hb00) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 380:59]
        mhpmcounter7 <= _GEN_15;
      end else if (io_reg_write_address_ex == 12'hb80) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 382:65]
        mhpmcounter7 <= _GEN_15;
      end else begin
        mhpmcounter7 <= _GEN_113;
      end
    end else begin
      mhpmcounter7 <= _GEN_15;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 177:29]
      mhpmcounter8 <= 64'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 177:29]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 379:32]
      if (io_reg_write_address_ex == 12'hb00) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 380:59]
        mhpmcounter8 <= _GEN_16;
      end else if (io_reg_write_address_ex == 12'hb80) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 382:65]
        mhpmcounter8 <= _GEN_16;
      end else begin
        mhpmcounter8 <= _GEN_114;
      end
    end else begin
      mhpmcounter8 <= _GEN_16;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 178:29]
      mhpmcounter9 <= 64'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 178:29]
    end else if (io_reg_write_enable_ex) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 379:32]
      if (io_reg_write_address_ex == 12'hb00) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 380:59]
        mhpmcounter9 <= _GEN_17;
      end else if (io_reg_write_address_ex == 12'hb80) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 382:65]
        mhpmcounter9 <= _GEN_17;
      end else begin
        mhpmcounter9 <= _GEN_115;
      end
    end else begin
      mhpmcounter9 <= _GEN_17;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 184:36]
      mcycle_shadow <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 184:36]
    end else if (reading_cycle_low) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 207:27]
      mcycle_shadow <= mcycle[63:32]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 208:19]
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 185:36]
      minstret_shadow <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 185:36]
    end else if (reading_instret_low) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 210:29]
      minstret_shadow <= minstret[63:32]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 211:21]
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 186:36]
      mhpmcounter3_shadow <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 186:36]
    end else if (reading_hpm3_low) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 213:26]
      mhpmcounter3_shadow <= mhpmcounter3[63:32]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 214:25]
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 187:36]
      mhpmcounter4_shadow <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 187:36]
    end else if (reading_hpm4_low) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 216:26]
      mhpmcounter4_shadow <= mhpmcounter4[63:32]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 217:25]
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 188:36]
      mhpmcounter5_shadow <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 188:36]
    end else if (reading_hpm5_low) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 219:26]
      mhpmcounter5_shadow <= mhpmcounter5[63:32]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 220:25]
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 189:36]
      mhpmcounter6_shadow <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 189:36]
    end else if (reading_hpm6_low) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 222:26]
      mhpmcounter6_shadow <= mhpmcounter6[63:32]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 223:25]
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 190:36]
      mhpmcounter7_shadow <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 190:36]
    end else if (reading_hpm7_low) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 225:26]
      mhpmcounter7_shadow <= mhpmcounter7[63:32]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 226:25]
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 191:36]
      mhpmcounter8_shadow <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 191:36]
    end else if (reading_hpm8_low) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 228:26]
      mhpmcounter8_shadow <= mhpmcounter8[63:32]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 229:25]
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 192:36]
      mhpmcounter9_shadow <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CSR.scala 192:36]
    end else if (reading_hpm9_low) begin // @[4-soc/src/main/scala/riscv/core/CSR.scala 231:26]
      mhpmcounter9_shadow <= mhpmcounter9[63:32]; // @[4-soc/src/main/scala/riscv/core/CSR.scala 232:25]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mstatus = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  mie = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  mtvec = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mscratch = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  mepc = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  mcause = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  mcountinhibit = _RAND_6[31:0];
  _RAND_7 = {2{`RANDOM}};
  mcycle = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  minstret = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  mhpmcounter3 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  mhpmcounter4 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  mhpmcounter5 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  mhpmcounter6 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  mhpmcounter7 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  mhpmcounter8 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  mhpmcounter9 = _RAND_15[63:0];
  _RAND_16 = {1{`RANDOM}};
  mcycle_shadow = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  minstret_shadow = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  mhpmcounter3_shadow = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mhpmcounter4_shadow = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  mhpmcounter5_shadow = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  mhpmcounter6_shadow = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  mhpmcounter7_shadow = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  mhpmcounter8_shadow = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  mhpmcounter9_shadow = _RAND_24[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PipelinedCPU(
  input         clock,
  input         reset,
  output [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  input  [31:0] io_instruction, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  input         io_instruction_valid, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output [31:0] io_memory_bundle_address, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output        io_memory_bundle_read, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  input  [31:0] io_memory_bundle_read_data, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  input         io_memory_bundle_read_valid, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output        io_memory_bundle_write, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output [31:0] io_memory_bundle_write_data, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output        io_memory_bundle_write_strobe_0, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output        io_memory_bundle_write_strobe_1, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output        io_memory_bundle_write_strobe_2, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output        io_memory_bundle_write_strobe_3, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  input         io_memory_bundle_write_valid, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output        io_memory_bundle_request, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  input         io_memory_bundle_granted, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output [2:0]  io_device_select, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  input  [31:0] io_interrupt_flag, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  input  [4:0]  io_debug_read_address, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output [31:0] io_debug_read_data, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  input  [11:0] io_csr_debug_read_address, // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
  output [31:0] io_csr_debug_read_data // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 116:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  ctrl_io_jump_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  ctrl_io_jump_instruction_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire [4:0] ctrl_io_rs1_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire [4:0] ctrl_io_rs2_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  ctrl_io_memory_read_enable_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire [4:0] ctrl_io_rd_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  ctrl_io_memory_read_enable_mem; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire [4:0] ctrl_io_rd_mem; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  ctrl_io_memory_write_enable_mem; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire [1:0] ctrl_io_regs_write_source_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire [1:0] ctrl_io_regs_write_source_mem; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire [1:0] ctrl_io_regs_write_source_wb; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire [4:0] ctrl_io_rd_wb; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  ctrl_io_if_flush; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  ctrl_io_id_flush; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  ctrl_io_pc_stall; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  ctrl_io_if_stall; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  ctrl_io_branch_hazard; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  ctrl_io_jal_jalr_hazard; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
  wire  regs_clock; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire  regs_reset; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire  regs_io_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire [4:0] regs_io_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire [31:0] regs_io_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire [4:0] regs_io_read_address1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire [4:0] regs_io_read_address2; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire [31:0] regs_io_read_data1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire [31:0] regs_io_read_data2; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire [4:0] regs_io_debug_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire [31:0] regs_io_debug_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
  wire  inst_fetch_clock; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_reset; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_stall_flag_ctrl; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_jump_flag_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_jump_address_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_rom_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_instruction_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_btb_mispredict; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_btb_correction_addr; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_btb_correct_prediction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_id_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_btb_predicted_taken; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_btb_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_btb_update_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_btb_update_pc; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_btb_update_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_btb_update_taken; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_ras_predicted_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_ras_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_ras_push; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_ras_push_addr; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_ibtb_predicted_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_ibtb_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  inst_fetch_io_ibtb_update_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_ibtb_update_pc; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [7:0] inst_fetch_io_ibtb_update_rs1_hash; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire [31:0] inst_fetch_io_ibtb_update_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
  wire  if2id_clock; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire  if2id_reset; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire  if2id_io_stall; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire  if2id_io_flush; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_interrupt_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire  if2id_io_btb_predicted_taken; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_btb_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire  if2id_io_ras_predicted_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_ras_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire  if2id_io_ibtb_predicted_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_ibtb_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_output_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire  if2id_io_output_btb_predicted_taken; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_output_btb_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire  if2id_io_output_ras_predicted_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_output_ras_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire  if2id_io_output_ibtb_predicted_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] if2id_io_output_ibtb_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
  wire [31:0] id_io_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [31:0] id_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [31:0] id_io_reg1_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [31:0] id_io_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [31:0] id_io_forward_from_mem; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [31:0] id_io_forward_from_wb; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [1:0] id_io_reg1_forward; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [1:0] id_io_reg2_forward; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_interrupt_assert; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [31:0] id_io_interrupt_handler_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_branch_hazard; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [4:0] id_io_regs_reg1_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [4:0] id_io_regs_reg2_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [31:0] id_io_ex_immediate; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_ex_aluop1_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_ex_aluop2_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_ex_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_ex_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [1:0] id_io_ex_reg_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_ex_reg_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [4:0] id_io_ex_reg_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [11:0] id_io_ex_csr_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_ex_csr_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_ctrl_jump_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_clint_jump_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [31:0] id_io_clint_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id_io_if_jump_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire [31:0] id_io_if_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
  wire  id2ex_clock; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_reset; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_stall; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_flush; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [4:0] id2ex_io_regs_reg1_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [4:0] id2ex_io_regs_reg2_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [4:0] id2ex_io_regs_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [1:0] id2ex_io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_reg1_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_immediate; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_aluop1_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_aluop2_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_csr_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [11:0] id2ex_io_csr_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_output_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [4:0] id2ex_io_output_regs_reg1_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [4:0] id2ex_io_output_regs_reg2_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_output_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [4:0] id2ex_io_output_regs_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [1:0] id2ex_io_output_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_output_reg1_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_output_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_output_immediate; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_output_aluop1_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_output_aluop2_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_output_csr_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [11:0] id2ex_io_output_csr_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_output_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire  id2ex_io_output_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] id2ex_io_output_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
  wire [31:0] ex_io_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [31:0] ex_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [31:0] ex_io_reg1_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [31:0] ex_io_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [31:0] ex_io_immediate; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire  ex_io_aluop1_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire  ex_io_aluop2_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [31:0] ex_io_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [31:0] ex_io_forward_from_mem; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [31:0] ex_io_forward_from_wb; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [1:0] ex_io_reg1_forward; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [1:0] ex_io_reg2_forward; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [31:0] ex_io_mem_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [31:0] ex_io_mem_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire [31:0] ex_io_csr_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
  wire  ex2mem_clock; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire  ex2mem_reset; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire  ex2mem_io_stall; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire  ex2mem_io_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [1:0] ex2mem_io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_regs_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [2:0] ex2mem_io_funct3; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire  ex2mem_io_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire  ex2mem_io_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire  ex2mem_io_output_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [1:0] ex2mem_io_output_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_output_regs_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_output_funct3; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_output_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire  ex2mem_io_output_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire  ex2mem_io_output_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_output_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire [31:0] ex2mem_io_output_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
  wire  mem_clock; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_reset; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [31:0] mem_io_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [31:0] mem_io_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [2:0] mem_io_funct3; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [1:0] mem_io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [4:0] mem_io_regs_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [31:0] mem_io_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [31:0] mem_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [31:0] mem_io_wb_memory_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [31:0] mem_io_forward_to_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_ctrl_stall_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [1:0] mem_io_wb_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [4:0] mem_io_wb_regs_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_wb_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [31:0] mem_io_bus_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_bus_read; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [31:0] mem_io_bus_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_bus_read_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_bus_write; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire [31:0] mem_io_bus_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_bus_write_strobe_0; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_bus_write_strobe_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_bus_write_strobe_2; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_bus_write_strobe_3; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_bus_write_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_bus_request; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem_io_bus_granted; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
  wire  mem2wb_clock; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire  mem2wb_reset; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire  mem2wb_io_stall; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] mem2wb_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] mem2wb_io_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire  mem2wb_io_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [1:0] mem2wb_io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] mem2wb_io_regs_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] mem2wb_io_memory_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] mem2wb_io_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] mem2wb_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] mem2wb_io_output_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire  mem2wb_io_output_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [1:0] mem2wb_io_output_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] mem2wb_io_output_regs_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] mem2wb_io_output_memory_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] mem2wb_io_output_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
  wire [31:0] wb_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 128:26]
  wire [31:0] wb_io_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 128:26]
  wire [31:0] wb_io_memory_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 128:26]
  wire [1:0] wb_io_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 128:26]
  wire [31:0] wb_io_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 128:26]
  wire [31:0] wb_io_regs_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 128:26]
  wire [4:0] forwarding_io_rs1_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire [4:0] forwarding_io_rs2_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire [4:0] forwarding_io_rs1_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire [4:0] forwarding_io_rs2_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire [4:0] forwarding_io_rd_mem; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire  forwarding_io_reg_write_enable_mem; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire [4:0] forwarding_io_rd_wb; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire  forwarding_io_reg_write_enable_wb; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire [1:0] forwarding_io_reg1_forward_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire [1:0] forwarding_io_reg2_forward_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire [1:0] forwarding_io_reg1_forward_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire [1:0] forwarding_io_reg2_forward_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
  wire [31:0] clint_io_interrupt_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_instruction_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_instruction_address_if; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire  clint_io_jump_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_id_interrupt_handler_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire  clint_io_id_interrupt_assert; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_csr_bundle_mstatus; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_csr_bundle_mepc; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_csr_bundle_mcause; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_csr_bundle_mtvec; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_csr_bundle_mie; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_csr_bundle_mstatus_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_csr_bundle_mepc_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire [31:0] clint_io_csr_bundle_mcause_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire  clint_io_csr_bundle_direct_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
  wire  csr_regs_clock; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_reset; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [11:0] csr_regs_io_reg_read_address_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_io_reg_write_enable_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [11:0] csr_regs_io_reg_write_address_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_reg_write_data_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [11:0] csr_regs_io_debug_reg_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_id_reg_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_debug_reg_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_clint_access_bundle_mstatus; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_clint_access_bundle_mepc; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_clint_access_bundle_mcause; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_clint_access_bundle_mtvec; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_clint_access_bundle_mie; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_clint_access_bundle_mstatus_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_clint_access_bundle_mepc_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire [31:0] csr_regs_io_clint_access_bundle_mcause_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_io_clint_access_bundle_direct_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_io_instruction_retired; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_io_branch_misprediction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_io_hazard_stall; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_io_memory_stall; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_io_control_stall; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_io_btb_miss_taken; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_io_branch_resolved; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  csr_regs_io_btb_predicted; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
  wire  _btb_wrong_direction_T = if2id_io_output_btb_predicted_taken & id_io_ctrl_jump_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 191:43]
  wire  btb_wrong_direction = if2id_io_output_btb_predicted_taken & id_io_ctrl_jump_instruction & ~id_io_if_jump_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 191:64]
  wire  btb_non_branch = if2id_io_output_btb_predicted_taken & ~id_io_ctrl_jump_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 195:38]
  wire  btb_actually_used = if2id_io_output_btb_predicted_taken & ~if2id_io_output_ras_predicted_valid & ~
    if2id_io_output_ibtb_predicted_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 200:59]
  wire  _btb_wrong_target_T = btb_actually_used & id_io_if_jump_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 203:44]
  wire  btb_wrong_target = btb_actually_used & id_io_if_jump_flag & if2id_io_output_btb_predicted_target !=
    id_io_if_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 203:60]
  wire  btb_correct_prediction = _btb_wrong_target_T & if2id_io_output_btb_predicted_target == id_io_if_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 206:66]
  wire  _btb_mispredict_raw_T_2 = ~id_io_branch_hazard; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 209:91]
  wire  btb_mispredict_raw = (btb_wrong_direction | btb_non_branch | btb_wrong_target) & ~id_io_branch_hazard; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 209:88]
  wire [31:0] _btb_correction_addr_raw_T_1 = if2id_io_output_instruction_address + 32'h4; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 214:106]
  wire [31:0] btb_correction_addr_raw = btb_wrong_target ? id_io_if_jump_address : _btb_correction_addr_raw_T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 214:36]
  reg  btb_mispredict_pending; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 218:44]
  reg [31:0] btb_correction_addr_pending; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 219:44]
  wire  _T_1 = ~mem_io_ctrl_stall_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 224:40]
  wire  _T_2 = btb_mispredict_pending & ~mem_io_ctrl_stall_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 224:37]
  wire  _GEN_0 = btb_mispredict_pending & ~mem_io_ctrl_stall_flag ? 1'h0 : btb_mispredict_pending; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 224:52 225:28 218:44]
  wire  _GEN_1 = mem_io_ctrl_stall_flag & btb_mispredict_raw | _GEN_0; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 221:41 222:33]
  wire  btb_mispredict = btb_mispredict_raw | _T_2; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 228:43]
  wire [6:0] id_opcode = if2id_io_output_instruction[6:0]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 251:38]
  wire [4:0] id_rd = if2id_io_output_instruction[11:7]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 252:38]
  wire [4:0] id_rs1 = if2id_io_output_instruction[19:15]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 253:38]
  wire  is_jal = id_opcode == 7'h6f; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 257:31]
  wire  is_jalr = id_opcode == 7'h67; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 258:31]
  wire  rd_is_link = id_rd == 5'h1 | id_rd == 5'h5; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 259:35]
  wire  rs1_is_link = id_rs1 == 5'h1 | id_rs1 == 5'h5; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 260:36]
  wire  is_return = is_jalr & rs1_is_link & id_rd == 5'h0; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 273:52]
  wire  _ras_wrong_target_T = if2id_io_output_ras_predicted_valid & is_return; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 274:43]
  wire  ras_wrong_target = if2id_io_output_ras_predicted_valid & is_return & if2id_io_output_ras_predicted_target !=
    id_io_if_jump_address & _btb_mispredict_raw_T_2; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 274:95]
  wire  ras_correct_predict = _ras_wrong_target_T & if2id_io_output_ras_predicted_target == id_io_if_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 275:56]
  wire  is_indirect_jalr = is_jalr & ~is_return; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 279:34]
  wire  _ibtb_wrong_target_T = if2id_io_output_ibtb_predicted_valid & is_indirect_jalr; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 281:20]
  wire  ibtb_wrong_target = if2id_io_output_ibtb_predicted_valid & is_indirect_jalr &
    if2id_io_output_ibtb_predicted_target != id_io_if_jump_address & _btb_mispredict_raw_T_2; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 281:80]
  wire  ibtb_correct_predict = _ibtb_wrong_target_T & if2id_io_output_ibtb_predicted_target == id_io_if_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 282:65]
  wire [31:0] _id_reg1_data_forwarded_T_1 = 2'h1 == forwarding_io_reg1_forward_id ? mem_io_forward_to_ex :
    regs_io_read_data1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 308:92]
  wire [31:0] id_reg1_data_forwarded = 2'h2 == forwarding_io_reg1_forward_id ? wb_io_regs_write_data :
    _id_reg1_data_forwarded_T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 308:92]
  wire [31:0] _id_reg2_data_forwarded_T_1 = 2'h1 == forwarding_io_reg2_forward_id ? mem_io_forward_to_ex :
    regs_io_read_data2; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 314:92]
  wire [7:0] ibtb_rs1_hash_b0 = id_reg1_data_forwarded[7:0]; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 176:19]
  wire [7:0] ibtb_rs1_hash_b1 = id_reg1_data_forwarded[15:8]; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 177:19]
  wire [7:0] ibtb_rs1_hash_b2 = id_reg1_data_forwarded[23:16]; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 178:19]
  wire [7:0] ibtb_rs1_hash_b3 = id_reg1_data_forwarded[31:24]; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 179:19]
  wire [7:0] _ibtb_rs1_hash_T = ibtb_rs1_hash_b0 ^ ibtb_rs1_hash_b1; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 180:8]
  wire [7:0] _ibtb_rs1_hash_T_1 = _ibtb_rs1_hash_T ^ ibtb_rs1_hash_b2; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 180:13]
  wire  prediction_correct = btb_correct_prediction | ras_correct_predict | ibtb_correct_predict; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 358:74]
  wire  need_if_flush = ctrl_io_if_flush & ~prediction_correct | btb_mispredict | ras_wrong_target | ibtb_wrong_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 360:85]
  wire  store_completed = mem_io_bus_write & mem_io_bus_write_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 523:47]
  wire  control_flush_event = (need_if_flush | btb_mispredict | ras_wrong_target | ibtb_wrong_target) & _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 554:104]
  wire  _btb_miss_penalty_T_3 = ~if2id_io_output_btb_predicted_taken & id_io_ctrl_jump_instruction & id_io_if_jump_flag
     | btb_wrong_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 573:59]
  Control ctrl ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 118:26]
    .io_jump_flag(ctrl_io_jump_flag),
    .io_jump_instruction_id(ctrl_io_jump_instruction_id),
    .io_rs1_id(ctrl_io_rs1_id),
    .io_rs2_id(ctrl_io_rs2_id),
    .io_memory_read_enable_ex(ctrl_io_memory_read_enable_ex),
    .io_rd_ex(ctrl_io_rd_ex),
    .io_memory_read_enable_mem(ctrl_io_memory_read_enable_mem),
    .io_rd_mem(ctrl_io_rd_mem),
    .io_memory_write_enable_mem(ctrl_io_memory_write_enable_mem),
    .io_regs_write_source_ex(ctrl_io_regs_write_source_ex),
    .io_regs_write_source_mem(ctrl_io_regs_write_source_mem),
    .io_regs_write_source_wb(ctrl_io_regs_write_source_wb),
    .io_rd_wb(ctrl_io_rd_wb),
    .io_if_flush(ctrl_io_if_flush),
    .io_id_flush(ctrl_io_id_flush),
    .io_pc_stall(ctrl_io_pc_stall),
    .io_if_stall(ctrl_io_if_stall),
    .io_branch_hazard(ctrl_io_branch_hazard),
    .io_jal_jalr_hazard(ctrl_io_jal_jalr_hazard)
  );
  RegisterFile regs ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 119:26]
    .clock(regs_clock),
    .reset(regs_reset),
    .io_write_enable(regs_io_write_enable),
    .io_write_address(regs_io_write_address),
    .io_write_data(regs_io_write_data),
    .io_read_address1(regs_io_read_address1),
    .io_read_address2(regs_io_read_address2),
    .io_read_data1(regs_io_read_data1),
    .io_read_data2(regs_io_read_data2),
    .io_debug_read_address(regs_io_debug_read_address),
    .io_debug_read_data(regs_io_debug_read_data)
  );
  InstructionFetch inst_fetch ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 120:26]
    .clock(inst_fetch_clock),
    .reset(inst_fetch_reset),
    .io_stall_flag_ctrl(inst_fetch_io_stall_flag_ctrl),
    .io_jump_flag_id(inst_fetch_io_jump_flag_id),
    .io_jump_address_id(inst_fetch_io_jump_address_id),
    .io_rom_instruction(inst_fetch_io_rom_instruction),
    .io_instruction_valid(inst_fetch_io_instruction_valid),
    .io_btb_mispredict(inst_fetch_io_btb_mispredict),
    .io_btb_correction_addr(inst_fetch_io_btb_correction_addr),
    .io_btb_correct_prediction(inst_fetch_io_btb_correct_prediction),
    .io_instruction_address(inst_fetch_io_instruction_address),
    .io_id_instruction(inst_fetch_io_id_instruction),
    .io_btb_predicted_taken(inst_fetch_io_btb_predicted_taken),
    .io_btb_predicted_target(inst_fetch_io_btb_predicted_target),
    .io_btb_update_valid(inst_fetch_io_btb_update_valid),
    .io_btb_update_pc(inst_fetch_io_btb_update_pc),
    .io_btb_update_target(inst_fetch_io_btb_update_target),
    .io_btb_update_taken(inst_fetch_io_btb_update_taken),
    .io_ras_predicted_valid(inst_fetch_io_ras_predicted_valid),
    .io_ras_predicted_target(inst_fetch_io_ras_predicted_target),
    .io_ras_push(inst_fetch_io_ras_push),
    .io_ras_push_addr(inst_fetch_io_ras_push_addr),
    .io_ibtb_predicted_valid(inst_fetch_io_ibtb_predicted_valid),
    .io_ibtb_predicted_target(inst_fetch_io_ibtb_predicted_target),
    .io_ibtb_update_valid(inst_fetch_io_ibtb_update_valid),
    .io_ibtb_update_pc(inst_fetch_io_ibtb_update_pc),
    .io_ibtb_update_rs1_hash(inst_fetch_io_ibtb_update_rs1_hash),
    .io_ibtb_update_target(inst_fetch_io_ibtb_update_target)
  );
  IF2ID if2id ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 121:26]
    .clock(if2id_clock),
    .reset(if2id_reset),
    .io_stall(if2id_io_stall),
    .io_flush(if2id_io_flush),
    .io_instruction(if2id_io_instruction),
    .io_instruction_address(if2id_io_instruction_address),
    .io_interrupt_flag(if2id_io_interrupt_flag),
    .io_btb_predicted_taken(if2id_io_btb_predicted_taken),
    .io_btb_predicted_target(if2id_io_btb_predicted_target),
    .io_ras_predicted_valid(if2id_io_ras_predicted_valid),
    .io_ras_predicted_target(if2id_io_ras_predicted_target),
    .io_ibtb_predicted_valid(if2id_io_ibtb_predicted_valid),
    .io_ibtb_predicted_target(if2id_io_ibtb_predicted_target),
    .io_output_instruction(if2id_io_output_instruction),
    .io_output_instruction_address(if2id_io_output_instruction_address),
    .io_output_btb_predicted_taken(if2id_io_output_btb_predicted_taken),
    .io_output_btb_predicted_target(if2id_io_output_btb_predicted_target),
    .io_output_ras_predicted_valid(if2id_io_output_ras_predicted_valid),
    .io_output_ras_predicted_target(if2id_io_output_ras_predicted_target),
    .io_output_ibtb_predicted_valid(if2id_io_output_ibtb_predicted_valid),
    .io_output_ibtb_predicted_target(if2id_io_output_ibtb_predicted_target)
  );
  InstructionDecode id ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 122:26]
    .io_instruction(id_io_instruction),
    .io_instruction_address(id_io_instruction_address),
    .io_reg1_data(id_io_reg1_data),
    .io_reg2_data(id_io_reg2_data),
    .io_forward_from_mem(id_io_forward_from_mem),
    .io_forward_from_wb(id_io_forward_from_wb),
    .io_reg1_forward(id_io_reg1_forward),
    .io_reg2_forward(id_io_reg2_forward),
    .io_interrupt_assert(id_io_interrupt_assert),
    .io_interrupt_handler_address(id_io_interrupt_handler_address),
    .io_branch_hazard(id_io_branch_hazard),
    .io_regs_reg1_read_address(id_io_regs_reg1_read_address),
    .io_regs_reg2_read_address(id_io_regs_reg2_read_address),
    .io_ex_immediate(id_io_ex_immediate),
    .io_ex_aluop1_source(id_io_ex_aluop1_source),
    .io_ex_aluop2_source(id_io_ex_aluop2_source),
    .io_ex_memory_read_enable(id_io_ex_memory_read_enable),
    .io_ex_memory_write_enable(id_io_ex_memory_write_enable),
    .io_ex_reg_write_source(id_io_ex_reg_write_source),
    .io_ex_reg_write_enable(id_io_ex_reg_write_enable),
    .io_ex_reg_write_address(id_io_ex_reg_write_address),
    .io_ex_csr_address(id_io_ex_csr_address),
    .io_ex_csr_write_enable(id_io_ex_csr_write_enable),
    .io_ctrl_jump_instruction(id_io_ctrl_jump_instruction),
    .io_clint_jump_flag(id_io_clint_jump_flag),
    .io_clint_jump_address(id_io_clint_jump_address),
    .io_if_jump_flag(id_io_if_jump_flag),
    .io_if_jump_address(id_io_if_jump_address)
  );
  ID2EX id2ex ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 123:26]
    .clock(id2ex_clock),
    .reset(id2ex_reset),
    .io_stall(id2ex_io_stall),
    .io_flush(id2ex_io_flush),
    .io_instruction(id2ex_io_instruction),
    .io_instruction_address(id2ex_io_instruction_address),
    .io_regs_reg1_read_address(id2ex_io_regs_reg1_read_address),
    .io_regs_reg2_read_address(id2ex_io_regs_reg2_read_address),
    .io_regs_write_enable(id2ex_io_regs_write_enable),
    .io_regs_write_address(id2ex_io_regs_write_address),
    .io_regs_write_source(id2ex_io_regs_write_source),
    .io_reg1_data(id2ex_io_reg1_data),
    .io_reg2_data(id2ex_io_reg2_data),
    .io_immediate(id2ex_io_immediate),
    .io_aluop1_source(id2ex_io_aluop1_source),
    .io_aluop2_source(id2ex_io_aluop2_source),
    .io_csr_write_enable(id2ex_io_csr_write_enable),
    .io_csr_address(id2ex_io_csr_address),
    .io_memory_read_enable(id2ex_io_memory_read_enable),
    .io_memory_write_enable(id2ex_io_memory_write_enable),
    .io_csr_read_data(id2ex_io_csr_read_data),
    .io_output_instruction(id2ex_io_output_instruction),
    .io_output_instruction_address(id2ex_io_output_instruction_address),
    .io_output_regs_reg1_read_address(id2ex_io_output_regs_reg1_read_address),
    .io_output_regs_reg2_read_address(id2ex_io_output_regs_reg2_read_address),
    .io_output_regs_write_enable(id2ex_io_output_regs_write_enable),
    .io_output_regs_write_address(id2ex_io_output_regs_write_address),
    .io_output_regs_write_source(id2ex_io_output_regs_write_source),
    .io_output_reg1_data(id2ex_io_output_reg1_data),
    .io_output_reg2_data(id2ex_io_output_reg2_data),
    .io_output_immediate(id2ex_io_output_immediate),
    .io_output_aluop1_source(id2ex_io_output_aluop1_source),
    .io_output_aluop2_source(id2ex_io_output_aluop2_source),
    .io_output_csr_write_enable(id2ex_io_output_csr_write_enable),
    .io_output_csr_address(id2ex_io_output_csr_address),
    .io_output_memory_read_enable(id2ex_io_output_memory_read_enable),
    .io_output_memory_write_enable(id2ex_io_output_memory_write_enable),
    .io_output_csr_read_data(id2ex_io_output_csr_read_data)
  );
  Execute ex ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 124:26]
    .io_instruction(ex_io_instruction),
    .io_instruction_address(ex_io_instruction_address),
    .io_reg1_data(ex_io_reg1_data),
    .io_reg2_data(ex_io_reg2_data),
    .io_immediate(ex_io_immediate),
    .io_aluop1_source(ex_io_aluop1_source),
    .io_aluop2_source(ex_io_aluop2_source),
    .io_csr_read_data(ex_io_csr_read_data),
    .io_forward_from_mem(ex_io_forward_from_mem),
    .io_forward_from_wb(ex_io_forward_from_wb),
    .io_reg1_forward(ex_io_reg1_forward),
    .io_reg2_forward(ex_io_reg2_forward),
    .io_mem_alu_result(ex_io_mem_alu_result),
    .io_mem_reg2_data(ex_io_mem_reg2_data),
    .io_csr_write_data(ex_io_csr_write_data)
  );
  EX2MEM ex2mem ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 125:26]
    .clock(ex2mem_clock),
    .reset(ex2mem_reset),
    .io_stall(ex2mem_io_stall),
    .io_regs_write_enable(ex2mem_io_regs_write_enable),
    .io_regs_write_source(ex2mem_io_regs_write_source),
    .io_regs_write_address(ex2mem_io_regs_write_address),
    .io_instruction_address(ex2mem_io_instruction_address),
    .io_funct3(ex2mem_io_funct3),
    .io_reg2_data(ex2mem_io_reg2_data),
    .io_memory_read_enable(ex2mem_io_memory_read_enable),
    .io_memory_write_enable(ex2mem_io_memory_write_enable),
    .io_alu_result(ex2mem_io_alu_result),
    .io_csr_read_data(ex2mem_io_csr_read_data),
    .io_output_regs_write_enable(ex2mem_io_output_regs_write_enable),
    .io_output_regs_write_source(ex2mem_io_output_regs_write_source),
    .io_output_regs_write_address(ex2mem_io_output_regs_write_address),
    .io_output_instruction_address(ex2mem_io_output_instruction_address),
    .io_output_funct3(ex2mem_io_output_funct3),
    .io_output_reg2_data(ex2mem_io_output_reg2_data),
    .io_output_memory_read_enable(ex2mem_io_output_memory_read_enable),
    .io_output_memory_write_enable(ex2mem_io_output_memory_write_enable),
    .io_output_alu_result(ex2mem_io_output_alu_result),
    .io_output_csr_read_data(ex2mem_io_output_csr_read_data)
  );
  MemoryAccess mem ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 126:26]
    .clock(mem_clock),
    .reset(mem_reset),
    .io_alu_result(mem_io_alu_result),
    .io_reg2_data(mem_io_reg2_data),
    .io_memory_read_enable(mem_io_memory_read_enable),
    .io_memory_write_enable(mem_io_memory_write_enable),
    .io_funct3(mem_io_funct3),
    .io_regs_write_source(mem_io_regs_write_source),
    .io_regs_write_address(mem_io_regs_write_address),
    .io_regs_write_enable(mem_io_regs_write_enable),
    .io_csr_read_data(mem_io_csr_read_data),
    .io_instruction_address(mem_io_instruction_address),
    .io_wb_memory_read_data(mem_io_wb_memory_read_data),
    .io_forward_to_ex(mem_io_forward_to_ex),
    .io_ctrl_stall_flag(mem_io_ctrl_stall_flag),
    .io_wb_regs_write_source(mem_io_wb_regs_write_source),
    .io_wb_regs_write_address(mem_io_wb_regs_write_address),
    .io_wb_regs_write_enable(mem_io_wb_regs_write_enable),
    .io_bus_address(mem_io_bus_address),
    .io_bus_read(mem_io_bus_read),
    .io_bus_read_data(mem_io_bus_read_data),
    .io_bus_read_valid(mem_io_bus_read_valid),
    .io_bus_write(mem_io_bus_write),
    .io_bus_write_data(mem_io_bus_write_data),
    .io_bus_write_strobe_0(mem_io_bus_write_strobe_0),
    .io_bus_write_strobe_1(mem_io_bus_write_strobe_1),
    .io_bus_write_strobe_2(mem_io_bus_write_strobe_2),
    .io_bus_write_strobe_3(mem_io_bus_write_strobe_3),
    .io_bus_write_valid(mem_io_bus_write_valid),
    .io_bus_request(mem_io_bus_request),
    .io_bus_granted(mem_io_bus_granted)
  );
  MEM2WB mem2wb ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 127:26]
    .clock(mem2wb_clock),
    .reset(mem2wb_reset),
    .io_stall(mem2wb_io_stall),
    .io_instruction_address(mem2wb_io_instruction_address),
    .io_alu_result(mem2wb_io_alu_result),
    .io_regs_write_enable(mem2wb_io_regs_write_enable),
    .io_regs_write_source(mem2wb_io_regs_write_source),
    .io_regs_write_address(mem2wb_io_regs_write_address),
    .io_memory_read_data(mem2wb_io_memory_read_data),
    .io_csr_read_data(mem2wb_io_csr_read_data),
    .io_output_instruction_address(mem2wb_io_output_instruction_address),
    .io_output_alu_result(mem2wb_io_output_alu_result),
    .io_output_regs_write_enable(mem2wb_io_output_regs_write_enable),
    .io_output_regs_write_source(mem2wb_io_output_regs_write_source),
    .io_output_regs_write_address(mem2wb_io_output_regs_write_address),
    .io_output_memory_read_data(mem2wb_io_output_memory_read_data),
    .io_output_csr_read_data(mem2wb_io_output_csr_read_data)
  );
  WriteBack wb ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 128:26]
    .io_instruction_address(wb_io_instruction_address),
    .io_alu_result(wb_io_alu_result),
    .io_memory_read_data(wb_io_memory_read_data),
    .io_regs_write_source(wb_io_regs_write_source),
    .io_csr_read_data(wb_io_csr_read_data),
    .io_regs_write_data(wb_io_regs_write_data)
  );
  Forwarding forwarding ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 129:26]
    .io_rs1_id(forwarding_io_rs1_id),
    .io_rs2_id(forwarding_io_rs2_id),
    .io_rs1_ex(forwarding_io_rs1_ex),
    .io_rs2_ex(forwarding_io_rs2_ex),
    .io_rd_mem(forwarding_io_rd_mem),
    .io_reg_write_enable_mem(forwarding_io_reg_write_enable_mem),
    .io_rd_wb(forwarding_io_rd_wb),
    .io_reg_write_enable_wb(forwarding_io_reg_write_enable_wb),
    .io_reg1_forward_id(forwarding_io_reg1_forward_id),
    .io_reg2_forward_id(forwarding_io_reg2_forward_id),
    .io_reg1_forward_ex(forwarding_io_reg1_forward_ex),
    .io_reg2_forward_ex(forwarding_io_reg2_forward_ex)
  );
  CLINT clint ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 130:26]
    .io_interrupt_flag(clint_io_interrupt_flag),
    .io_instruction_id(clint_io_instruction_id),
    .io_instruction_address_if(clint_io_instruction_address_if),
    .io_jump_flag(clint_io_jump_flag),
    .io_jump_address(clint_io_jump_address),
    .io_id_interrupt_handler_address(clint_io_id_interrupt_handler_address),
    .io_id_interrupt_assert(clint_io_id_interrupt_assert),
    .io_csr_bundle_mstatus(clint_io_csr_bundle_mstatus),
    .io_csr_bundle_mepc(clint_io_csr_bundle_mepc),
    .io_csr_bundle_mcause(clint_io_csr_bundle_mcause),
    .io_csr_bundle_mtvec(clint_io_csr_bundle_mtvec),
    .io_csr_bundle_mie(clint_io_csr_bundle_mie),
    .io_csr_bundle_mstatus_write_data(clint_io_csr_bundle_mstatus_write_data),
    .io_csr_bundle_mepc_write_data(clint_io_csr_bundle_mepc_write_data),
    .io_csr_bundle_mcause_write_data(clint_io_csr_bundle_mcause_write_data),
    .io_csr_bundle_direct_write_enable(clint_io_csr_bundle_direct_write_enable)
  );
  CSR csr_regs ( // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 131:26]
    .clock(csr_regs_clock),
    .reset(csr_regs_reset),
    .io_reg_read_address_id(csr_regs_io_reg_read_address_id),
    .io_reg_write_enable_ex(csr_regs_io_reg_write_enable_ex),
    .io_reg_write_address_ex(csr_regs_io_reg_write_address_ex),
    .io_reg_write_data_ex(csr_regs_io_reg_write_data_ex),
    .io_debug_reg_read_address(csr_regs_io_debug_reg_read_address),
    .io_id_reg_read_data(csr_regs_io_id_reg_read_data),
    .io_debug_reg_read_data(csr_regs_io_debug_reg_read_data),
    .io_clint_access_bundle_mstatus(csr_regs_io_clint_access_bundle_mstatus),
    .io_clint_access_bundle_mepc(csr_regs_io_clint_access_bundle_mepc),
    .io_clint_access_bundle_mcause(csr_regs_io_clint_access_bundle_mcause),
    .io_clint_access_bundle_mtvec(csr_regs_io_clint_access_bundle_mtvec),
    .io_clint_access_bundle_mie(csr_regs_io_clint_access_bundle_mie),
    .io_clint_access_bundle_mstatus_write_data(csr_regs_io_clint_access_bundle_mstatus_write_data),
    .io_clint_access_bundle_mepc_write_data(csr_regs_io_clint_access_bundle_mepc_write_data),
    .io_clint_access_bundle_mcause_write_data(csr_regs_io_clint_access_bundle_mcause_write_data),
    .io_clint_access_bundle_direct_write_enable(csr_regs_io_clint_access_bundle_direct_write_enable),
    .io_instruction_retired(csr_regs_io_instruction_retired),
    .io_branch_misprediction(csr_regs_io_branch_misprediction),
    .io_hazard_stall(csr_regs_io_hazard_stall),
    .io_memory_stall(csr_regs_io_memory_stall),
    .io_control_stall(csr_regs_io_control_stall),
    .io_btb_miss_taken(csr_regs_io_btb_miss_taken),
    .io_branch_resolved(csr_regs_io_branch_resolved),
    .io_btb_predicted(csr_regs_io_btb_predicted)
  );
  assign io_instruction_address = inst_fetch_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 163:35]
  assign io_memory_bundle_address = {3'h0,mem_io_bus_address[28:0]}; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 453:70]
  assign io_memory_bundle_read = mem_io_bus_read; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign io_memory_bundle_write = mem_io_bus_write; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign io_memory_bundle_write_data = mem_io_bus_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign io_memory_bundle_write_strobe_0 = mem_io_bus_write_strobe_0; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign io_memory_bundle_write_strobe_1 = mem_io_bus_write_strobe_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign io_memory_bundle_write_strobe_2 = mem_io_bus_write_strobe_2; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign io_memory_bundle_write_strobe_3 = mem_io_bus_write_strobe_3; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign io_memory_bundle_request = mem_io_bus_request; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign io_device_select = mem_io_bus_address[31:29]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 451:13]
  assign io_debug_read_data = regs_io_debug_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 157:30]
  assign io_csr_debug_read_data = csr_regs_io_debug_reg_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 495:38]
  assign ctrl_io_jump_flag = id_io_if_jump_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 133:35]
  assign ctrl_io_jump_instruction_id = id_io_ctrl_jump_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 134:35]
  assign ctrl_io_rs1_id = id_io_regs_reg1_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 135:35]
  assign ctrl_io_rs2_id = id_io_regs_reg2_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 136:35]
  assign ctrl_io_memory_read_enable_ex = id2ex_io_output_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 137:35]
  assign ctrl_io_rd_ex = id2ex_io_output_regs_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 138:35]
  assign ctrl_io_memory_read_enable_mem = ex2mem_io_output_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 139:35]
  assign ctrl_io_rd_mem = ex2mem_io_output_regs_write_address[4:0]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 140:35]
  assign ctrl_io_memory_write_enable_mem = ex2mem_io_output_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 142:35]
  assign ctrl_io_regs_write_source_ex = id2ex_io_output_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 144:35]
  assign ctrl_io_regs_write_source_mem = ex2mem_io_output_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 145:35]
  assign ctrl_io_regs_write_source_wb = mem2wb_io_output_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 147:32]
  assign ctrl_io_rd_wb = mem2wb_io_output_regs_write_address[4:0]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 148:32]
  assign regs_clock = clock;
  assign regs_reset = reset;
  assign regs_io_write_enable = mem2wb_io_output_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 150:25]
  assign regs_io_write_address = mem2wb_io_output_regs_write_address[4:0]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 151:25]
  assign regs_io_write_data = wb_io_regs_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 152:25]
  assign regs_io_read_address1 = id_io_regs_reg1_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 153:25]
  assign regs_io_read_address2 = id_io_regs_reg2_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 154:25]
  assign regs_io_debug_read_address = io_debug_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 156:30]
  assign inst_fetch_clock = clock;
  assign inst_fetch_reset = reset;
  assign inst_fetch_io_stall_flag_ctrl = ctrl_io_pc_stall | mem_io_ctrl_stall_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 164:55]
  assign inst_fetch_io_jump_flag_id = id_io_if_jump_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 165:35]
  assign inst_fetch_io_jump_address_id = id_io_if_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 166:35]
  assign inst_fetch_io_rom_instruction = io_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 167:35]
  assign inst_fetch_io_instruction_valid = io_instruction_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 168:35]
  assign inst_fetch_io_btb_mispredict = btb_mispredict_raw | _T_2; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 228:43]
  assign inst_fetch_io_btb_correction_addr = _T_2 ? btb_correction_addr_pending : btb_correction_addr_raw; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 229:42]
  assign inst_fetch_io_btb_correct_prediction = _btb_wrong_target_T & if2id_io_output_btb_predicted_target ==
    id_io_if_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 206:66]
  assign inst_fetch_io_btb_update_valid = (id_io_ctrl_jump_instruction | btb_non_branch) & _btb_mispredict_raw_T_2 &
    _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 242:95]
  assign inst_fetch_io_btb_update_pc = if2id_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 244:35]
  assign inst_fetch_io_btb_update_target = id_io_if_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 245:35]
  assign inst_fetch_io_btb_update_taken = id_io_if_jump_flag & id_io_ctrl_jump_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 246:57]
  assign inst_fetch_io_ras_push = (is_jal | is_jalr) & rd_is_link & _btb_mispredict_raw_T_2 & _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 264:84]
  assign inst_fetch_io_ras_push_addr = if2id_io_output_instruction_address + 32'h4; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 265:62]
  assign inst_fetch_io_ibtb_update_valid = is_indirect_jalr & _btb_mispredict_raw_T_2 & _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 325:69]
  assign inst_fetch_io_ibtb_update_pc = if2id_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 327:38]
  assign inst_fetch_io_ibtb_update_rs1_hash = _ibtb_rs1_hash_T_1 ^ ibtb_rs1_hash_b3; // @[4-soc/src/main/scala/riscv/core/IndirectBTB.scala 180:18]
  assign inst_fetch_io_ibtb_update_target = id_io_if_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 329:38]
  assign if2id_clock = clock;
  assign if2id_reset = reset;
  assign if2id_io_stall = ctrl_io_if_stall | mem_io_ctrl_stall_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 331:38]
  assign if2id_io_flush = need_if_flush & _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 361:51]
  assign if2id_io_instruction = inst_fetch_io_id_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 362:34]
  assign if2id_io_instruction_address = inst_fetch_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 363:34]
  assign if2id_io_interrupt_flag = io_interrupt_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 364:34]
  assign if2id_io_btb_predicted_taken = inst_fetch_io_btb_predicted_taken; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 365:34]
  assign if2id_io_btb_predicted_target = inst_fetch_io_btb_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 366:34]
  assign if2id_io_ras_predicted_valid = inst_fetch_io_ras_predicted_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 367:34]
  assign if2id_io_ras_predicted_target = inst_fetch_io_ras_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 368:34]
  assign if2id_io_ibtb_predicted_valid = inst_fetch_io_ibtb_predicted_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 369:34]
  assign if2id_io_ibtb_predicted_target = inst_fetch_io_ibtb_predicted_target; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 370:34]
  assign id_io_instruction = if2id_io_output_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 372:35]
  assign id_io_instruction_address = if2id_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 373:35]
  assign id_io_reg1_data = regs_io_read_data1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 374:35]
  assign id_io_reg2_data = regs_io_read_data2; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 375:35]
  assign id_io_forward_from_mem = mem_io_forward_to_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 376:35]
  assign id_io_forward_from_wb = wb_io_regs_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 377:35]
  assign id_io_reg1_forward = forwarding_io_reg1_forward_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 378:35]
  assign id_io_reg2_forward = forwarding_io_reg2_forward_id; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 379:35]
  assign id_io_interrupt_assert = clint_io_id_interrupt_assert; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 380:35]
  assign id_io_interrupt_handler_address = clint_io_id_interrupt_handler_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 381:35]
  assign id_io_branch_hazard = ctrl_io_branch_hazard; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 382:35]
  assign id2ex_clock = clock;
  assign id2ex_reset = reset;
  assign id2ex_io_stall = mem_io_ctrl_stall_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 384:18]
  assign id2ex_io_flush = ctrl_io_id_flush & (_T_1 | ctrl_io_jal_jalr_hazard); // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 394:52]
  assign id2ex_io_instruction = if2id_io_output_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 395:32]
  assign id2ex_io_instruction_address = if2id_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 396:32]
  assign id2ex_io_regs_reg1_read_address = id_io_regs_reg1_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 401:35]
  assign id2ex_io_regs_reg2_read_address = id_io_regs_reg2_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 402:35]
  assign id2ex_io_regs_write_enable = id_io_ex_reg_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 403:35]
  assign id2ex_io_regs_write_address = id_io_ex_reg_write_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 404:35]
  assign id2ex_io_regs_write_source = id_io_ex_reg_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 405:35]
  assign id2ex_io_reg1_data = 2'h2 == forwarding_io_reg1_forward_id ? wb_io_regs_write_data :
    _id_reg1_data_forwarded_T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 308:92]
  assign id2ex_io_reg2_data = 2'h2 == forwarding_io_reg2_forward_id ? wb_io_regs_write_data :
    _id_reg2_data_forwarded_T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 314:92]
  assign id2ex_io_immediate = id_io_ex_immediate; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 406:35]
  assign id2ex_io_aluop1_source = id_io_ex_aluop1_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 407:35]
  assign id2ex_io_aluop2_source = id_io_ex_aluop2_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 408:35]
  assign id2ex_io_csr_write_enable = id_io_ex_csr_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 409:35]
  assign id2ex_io_csr_address = id_io_ex_csr_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 410:35]
  assign id2ex_io_memory_read_enable = id_io_ex_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 411:35]
  assign id2ex_io_memory_write_enable = id_io_ex_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 412:35]
  assign id2ex_io_csr_read_data = csr_regs_io_id_reg_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 413:35]
  assign ex_io_instruction = id2ex_io_output_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 415:29]
  assign ex_io_instruction_address = id2ex_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 416:29]
  assign ex_io_reg1_data = id2ex_io_output_reg1_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 417:29]
  assign ex_io_reg2_data = id2ex_io_output_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 418:29]
  assign ex_io_immediate = id2ex_io_output_immediate; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 419:29]
  assign ex_io_aluop1_source = id2ex_io_output_aluop1_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 420:29]
  assign ex_io_aluop2_source = id2ex_io_output_aluop2_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 421:29]
  assign ex_io_csr_read_data = id2ex_io_output_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 422:29]
  assign ex_io_forward_from_mem = mem_io_forward_to_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 423:29]
  assign ex_io_forward_from_wb = wb_io_regs_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 424:29]
  assign ex_io_reg1_forward = forwarding_io_reg1_forward_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 425:29]
  assign ex_io_reg2_forward = forwarding_io_reg2_forward_ex; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 426:29]
  assign ex2mem_clock = clock;
  assign ex2mem_reset = reset;
  assign ex2mem_io_stall = mem_io_ctrl_stall_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 428:33]
  assign ex2mem_io_regs_write_enable = id2ex_io_output_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 429:33]
  assign ex2mem_io_regs_write_source = id2ex_io_output_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 430:33]
  assign ex2mem_io_regs_write_address = {{27'd0}, id2ex_io_output_regs_write_address}; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 431:33]
  assign ex2mem_io_instruction_address = id2ex_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 432:33]
  assign ex2mem_io_funct3 = id2ex_io_output_instruction[14:12]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 433:63]
  assign ex2mem_io_reg2_data = ex_io_mem_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 434:33]
  assign ex2mem_io_memory_read_enable = id2ex_io_output_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 435:33]
  assign ex2mem_io_memory_write_enable = id2ex_io_output_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 436:33]
  assign ex2mem_io_alu_result = ex_io_mem_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 437:33]
  assign ex2mem_io_csr_read_data = id2ex_io_output_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 438:33]
  assign mem_clock = clock;
  assign mem_reset = reset;
  assign mem_io_alu_result = ex2mem_io_output_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 440:30]
  assign mem_io_reg2_data = ex2mem_io_output_reg2_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 441:30]
  assign mem_io_memory_read_enable = ex2mem_io_output_memory_read_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 442:30]
  assign mem_io_memory_write_enable = ex2mem_io_output_memory_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 443:30]
  assign mem_io_funct3 = ex2mem_io_output_funct3[2:0]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 444:30]
  assign mem_io_regs_write_source = ex2mem_io_output_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 445:30]
  assign mem_io_regs_write_address = ex2mem_io_output_regs_write_address[4:0]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 446:30]
  assign mem_io_regs_write_enable = ex2mem_io_output_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 447:30]
  assign mem_io_csr_read_data = ex2mem_io_output_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 448:30]
  assign mem_io_instruction_address = ex2mem_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 449:30]
  assign mem_io_bus_read_data = io_memory_bundle_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign mem_io_bus_read_valid = io_memory_bundle_read_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign mem_io_bus_write_valid = io_memory_bundle_write_valid; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign mem_io_bus_granted = io_memory_bundle_granted; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 452:20]
  assign mem2wb_clock = clock;
  assign mem2wb_reset = reset;
  assign mem2wb_io_stall = mem_io_ctrl_stall_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 456:33]
  assign mem2wb_io_instruction_address = ex2mem_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 457:33]
  assign mem2wb_io_alu_result = ex2mem_io_output_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 458:33]
  assign mem2wb_io_regs_write_enable = mem_io_wb_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 462:32]
  assign mem2wb_io_regs_write_source = mem_io_wb_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 463:32]
  assign mem2wb_io_regs_write_address = {{27'd0}, mem_io_wb_regs_write_address}; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 464:32]
  assign mem2wb_io_memory_read_data = mem_io_wb_memory_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 465:32]
  assign mem2wb_io_csr_read_data = ex2mem_io_output_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 466:32]
  assign wb_io_instruction_address = mem2wb_io_output_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 468:29]
  assign wb_io_alu_result = mem2wb_io_output_alu_result; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 469:29]
  assign wb_io_memory_read_data = mem2wb_io_output_memory_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 470:29]
  assign wb_io_regs_write_source = mem2wb_io_output_regs_write_source; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 471:29]
  assign wb_io_csr_read_data = mem2wb_io_output_csr_read_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 472:29]
  assign forwarding_io_rs1_id = id_io_regs_reg1_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 474:38]
  assign forwarding_io_rs2_id = id_io_regs_reg2_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 475:38]
  assign forwarding_io_rs1_ex = id2ex_io_output_regs_reg1_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 476:38]
  assign forwarding_io_rs2_ex = id2ex_io_output_regs_reg2_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 477:38]
  assign forwarding_io_rd_mem = ex2mem_io_output_regs_write_address[4:0]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 478:38]
  assign forwarding_io_reg_write_enable_mem = ex2mem_io_output_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 479:38]
  assign forwarding_io_rd_wb = mem2wb_io_output_regs_write_address[4:0]; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 480:38]
  assign forwarding_io_reg_write_enable_wb = mem2wb_io_output_regs_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 481:38]
  assign clint_io_interrupt_flag = io_interrupt_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 487:35]
  assign clint_io_instruction_id = if2id_io_output_instruction; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 484:35]
  assign clint_io_instruction_address_if = inst_fetch_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 483:35]
  assign clint_io_jump_flag = id_io_clint_jump_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 485:35]
  assign clint_io_jump_address = id_io_clint_jump_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 486:35]
  assign clint_io_csr_bundle_mstatus = csr_regs_io_clint_access_bundle_mstatus; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 488:23]
  assign clint_io_csr_bundle_mepc = csr_regs_io_clint_access_bundle_mepc; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 488:23]
  assign clint_io_csr_bundle_mcause = csr_regs_io_clint_access_bundle_mcause; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 488:23]
  assign clint_io_csr_bundle_mtvec = csr_regs_io_clint_access_bundle_mtvec; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 488:23]
  assign clint_io_csr_bundle_mie = csr_regs_io_clint_access_bundle_mie; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 488:23]
  assign csr_regs_clock = clock;
  assign csr_regs_reset = reset;
  assign csr_regs_io_reg_read_address_id = id_io_ex_csr_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 490:38]
  assign csr_regs_io_reg_write_enable_ex = id2ex_io_output_csr_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 491:38]
  assign csr_regs_io_reg_write_address_ex = id2ex_io_output_csr_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 492:38]
  assign csr_regs_io_reg_write_data_ex = ex_io_csr_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 493:38]
  assign csr_regs_io_debug_reg_read_address = io_csr_debug_read_address; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 494:38]
  assign csr_regs_io_clint_access_bundle_mstatus_write_data = clint_io_csr_bundle_mstatus_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 488:23]
  assign csr_regs_io_clint_access_bundle_mepc_write_data = clint_io_csr_bundle_mepc_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 488:23]
  assign csr_regs_io_clint_access_bundle_mcause_write_data = clint_io_csr_bundle_mcause_write_data; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 488:23]
  assign csr_regs_io_clint_access_bundle_direct_write_enable = clint_io_csr_bundle_direct_write_enable; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 488:23]
  assign csr_regs_io_instruction_retired = (mem2wb_io_output_regs_write_enable | store_completed) & _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 524:80]
  assign csr_regs_io_branch_misprediction = (btb_mispredict | ras_wrong_target | ibtb_wrong_target) & _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 530:97]
  assign csr_regs_io_hazard_stall = ctrl_io_pc_stall & _T_1 & ~control_flush_event; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 562:62]
  assign csr_regs_io_memory_stall = mem_io_ctrl_stall_flag; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 540:28]
  assign csr_regs_io_control_stall = (need_if_flush | btb_mispredict | ras_wrong_target | ibtb_wrong_target) & _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 554:104]
  assign csr_regs_io_btb_miss_taken = _btb_miss_penalty_T_3 & _btb_mispredict_raw_T_2 & _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 575:29]
  assign csr_regs_io_branch_resolved = id_io_ctrl_jump_instruction & _btb_mispredict_raw_T_2 & _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 585:76]
  assign csr_regs_io_btb_predicted = _btb_wrong_direction_T & _btb_mispredict_raw_T_2 & _T_1; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 593:91]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 218:44]
      btb_mispredict_pending <= 1'h0; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 218:44]
    end else begin
      btb_mispredict_pending <= _GEN_1;
    end
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 219:44]
      btb_correction_addr_pending <= 32'h0; // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 219:44]
    end else if (mem_io_ctrl_stall_flag & btb_mispredict_raw) begin // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 221:41]
      if (btb_wrong_target) begin // @[4-soc/src/main/scala/riscv/core/PipelinedCPU.scala 214:36]
        btb_correction_addr_pending <= id_io_if_jump_address;
      end else begin
        btb_correction_addr_pending <= _btb_correction_addr_raw_T_1;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  btb_mispredict_pending = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  btb_correction_addr_pending = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXI4LiteMaster(
  input         clock,
  input         reset,
  output        io_channels_write_address_channel_AWVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_channels_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output [31:0] io_channels_write_address_channel_AWADDR, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output        io_channels_write_data_channel_WVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_channels_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output [31:0] io_channels_write_data_channel_WDATA, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output [3:0]  io_channels_write_data_channel_WSTRB, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_channels_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output        io_channels_write_response_channel_BREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output        io_channels_read_address_channel_ARVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_channels_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output [31:0] io_channels_read_address_channel_ARADDR, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_channels_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output        io_channels_read_data_channel_RREADY, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input  [31:0] io_channels_read_data_channel_RDATA, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input  [31:0] io_bundle_address, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_bundle_read, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_bundle_write, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output [31:0] io_bundle_read_data, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input  [31:0] io_bundle_write_data, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_bundle_write_strobe_0, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_bundle_write_strobe_1, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_bundle_write_strobe_2, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  input         io_bundle_write_strobe_3, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output        io_bundle_busy, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output        io_bundle_read_valid, // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
  output        io_bundle_write_valid // @[4-soc/src/main/scala/bus/AXI4Lite.scala 249:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 254:22]
  reg [31:0] addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 257:21]
  reg  read_valid; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 262:27]
  reg [31:0] read_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 264:26]
  reg  ARVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 267:24]
  reg  RREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 269:23]
  reg  write_valid; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 275:28]
  reg [31:0] write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 277:27]
  reg  write_strobe_0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
  reg  write_strobe_1; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
  reg  write_strobe_2; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
  reg  write_strobe_3; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
  wire [1:0] io_channels_write_data_channel_WSTRB_lo = {write_strobe_1,write_strobe_0}; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 280:56]
  wire [1:0] io_channels_write_data_channel_WSTRB_hi = {write_strobe_3,write_strobe_2}; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 280:56]
  reg  AWVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 282:24]
  reg  WVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 284:23]
  reg  BREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 286:23]
  wire  _GEN_6 = io_bundle_write | AWVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 311:35 316:22 282:24]
  wire  _GEN_7 = io_bundle_write | WVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 311:35 317:22 284:23]
  wire  _GEN_10 = io_bundle_read & ~io_bundle_write | ARVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48 308:17 267:24]
  wire  _GEN_11 = io_bundle_read & ~io_bundle_write | RREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48 309:17 269:23]
  wire  _GEN_23 = io_channels_read_data_channel_RVALID & RREADY | read_valid; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 328:60 332:20 262:27]
  wire  _GEN_25 = AWVALID & io_channels_write_address_channel_AWREADY ? 1'h0 : AWVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 339:66 340:17 282:24]
  wire  _GEN_26 = WVALID & io_channels_write_data_channel_WREADY ? 1'h0 : WVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 284:23 343:61 345:29]
  wire  _GEN_27 = WVALID & io_channels_write_data_channel_WREADY | BREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 286:23 343:61 346:29]
  wire [2:0] _GEN_29 = WVALID & io_channels_write_data_channel_WREADY ? 3'h5 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 254:22 343:61 348:29]
  wire  _GEN_31 = io_channels_write_response_channel_BVALID & BREADY ? 1'h0 : BREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 359:65 361:21 286:23]
  wire  _GEN_32 = io_channels_write_response_channel_BVALID & BREADY | write_valid; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 359:65 362:21 275:28]
  wire [2:0] _GEN_33 = io_channels_write_response_channel_BVALID & BREADY ? 3'h0 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 359:65 363:21 254:22]
  wire  _GEN_34 = 3'h5 == state ? _GEN_25 : AWVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17 282:24]
  wire  _GEN_35 = 3'h5 == state ? _GEN_31 : BREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17 286:23]
  wire  _GEN_36 = 3'h5 == state ? _GEN_32 : write_valid; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17 275:28]
  wire [2:0] _GEN_37 = 3'h5 == state ? _GEN_33 : state; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17 254:22]
  assign io_channels_write_address_channel_AWVALID = AWVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 283:45]
  assign io_channels_write_address_channel_AWADDR = addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 259:44]
  assign io_channels_write_data_channel_WVALID = WVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 285:41]
  assign io_channels_write_data_channel_WDATA = write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 278:40]
  assign io_channels_write_data_channel_WSTRB = {io_channels_write_data_channel_WSTRB_hi,
    io_channels_write_data_channel_WSTRB_lo}; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 280:56]
  assign io_channels_write_response_channel_BREADY = BREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 287:45]
  assign io_channels_read_address_channel_ARVALID = ARVALID; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 268:44]
  assign io_channels_read_address_channel_ARADDR = addr; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 258:44]
  assign io_channels_read_data_channel_RREADY = RREADY; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 270:40]
  assign io_bundle_read_data = read_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 265:23]
  assign io_bundle_busy = state != 3'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 255:27]
  assign io_bundle_read_valid = read_valid; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 263:24]
  assign io_bundle_write_valid = write_valid; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 276:25]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 254:22]
      state <= 3'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 254:22]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (io_bundle_read & ~io_bundle_write) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48]
        state <= 3'h2; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 310:17]
      end else if (io_bundle_write) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 311:35]
        state <= 3'h4; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 318:22]
      end
    end else if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (io_channels_read_data_channel_RVALID & RREADY) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 328:60]
        state <= 3'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 333:20]
      end
    end else if (3'h4 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      state <= _GEN_29;
    end else begin
      state <= _GEN_37;
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 257:21]
      addr <= 32'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 257:21]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (io_bundle_read & ~io_bundle_write) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48]
        addr <= io_bundle_address; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 307:17]
      end else if (io_bundle_write) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 311:35]
        addr <= io_bundle_address; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 313:22]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 262:27]
      read_valid <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 262:27]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      read_valid <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 301:27]
    end else if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      read_valid <= _GEN_23;
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 264:26]
      read_data <= 32'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 264:26]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
        if (io_channels_read_data_channel_RVALID & RREADY) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 328:60]
          read_data <= io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 330:20]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 267:24]
      ARVALID <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 267:24]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      ARVALID <= _GEN_10;
    end else if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (ARVALID & io_channels_read_address_channel_ARREADY) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 324:65]
        ARVALID <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 325:17]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 269:23]
      RREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 269:23]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      RREADY <= _GEN_11;
    end else if (3'h2 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (io_channels_read_data_channel_RVALID & RREADY) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 328:60]
        RREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 331:20]
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 275:28]
      write_valid <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 275:28]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      write_valid <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 302:27]
    end else if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (!(3'h4 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
        write_valid <= _GEN_36;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 277:27]
      write_data <= 32'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 277:27]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (!(io_bundle_read & ~io_bundle_write)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48]
        if (io_bundle_write) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 311:35]
          write_data <= io_bundle_write_data; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 314:22]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
      write_strobe_0 <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (!(io_bundle_read & ~io_bundle_write)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48]
        if (io_bundle_write) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 311:35]
          write_strobe_0 <= io_bundle_write_strobe_0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 315:22]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
      write_strobe_1 <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (!(io_bundle_read & ~io_bundle_write)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48]
        if (io_bundle_write) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 311:35]
          write_strobe_1 <= io_bundle_write_strobe_1; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 315:22]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
      write_strobe_2 <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (!(io_bundle_read & ~io_bundle_write)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48]
        if (io_bundle_write) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 311:35]
          write_strobe_2 <= io_bundle_write_strobe_2; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 315:22]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
      write_strobe_3 <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 279:29]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (!(io_bundle_read & ~io_bundle_write)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48]
        if (io_bundle_write) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 311:35]
          write_strobe_3 <= io_bundle_write_strobe_3; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 315:22]
        end
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 282:24]
      AWVALID <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 282:24]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (!(io_bundle_read & ~io_bundle_write)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48]
        AWVALID <= _GEN_6;
      end
    end else if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (3'h4 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
        AWVALID <= _GEN_25;
      end else begin
        AWVALID <= _GEN_34;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 284:23]
      WVALID <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 284:23]
    end else if (3'h0 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (!(io_bundle_read & ~io_bundle_write)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 305:48]
        WVALID <= _GEN_7;
      end
    end else if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (3'h4 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
        WVALID <= _GEN_26;
      end
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 286:23]
      BREADY <= 1'h0; // @[4-soc/src/main/scala/bus/AXI4Lite.scala 286:23]
    end else if (!(3'h0 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
      if (!(3'h2 == state)) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
        if (3'h4 == state) begin // @[4-soc/src/main/scala/bus/AXI4Lite.scala 299:17]
          BREADY <= _GEN_27;
        end else begin
          BREADY <= _GEN_35;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  addr = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  read_valid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  read_data = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  ARVALID = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  RREADY = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  write_valid = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  write_data = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  write_strobe_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  write_strobe_1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  write_strobe_2 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  write_strobe_3 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  AWVALID = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  WVALID = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  BREADY = _RAND_14[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CPU(
  input         clock,
  input         reset,
  output [31:0] io_instruction_address, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input  [31:0] io_instruction, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input         io_instruction_valid, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output        io_axi4_channels_write_address_channel_AWVALID, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input         io_axi4_channels_write_address_channel_AWREADY, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output [31:0] io_axi4_channels_write_address_channel_AWADDR, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output        io_axi4_channels_write_data_channel_WVALID, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input         io_axi4_channels_write_data_channel_WREADY, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output [31:0] io_axi4_channels_write_data_channel_WDATA, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output [3:0]  io_axi4_channels_write_data_channel_WSTRB, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input         io_axi4_channels_write_response_channel_BVALID, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output        io_axi4_channels_write_response_channel_BREADY, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output        io_axi4_channels_read_address_channel_ARVALID, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input         io_axi4_channels_read_address_channel_ARREADY, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output [31:0] io_axi4_channels_read_address_channel_ARADDR, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input         io_axi4_channels_read_data_channel_RVALID, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output        io_axi4_channels_read_data_channel_RREADY, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input  [31:0] io_axi4_channels_read_data_channel_RDATA, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input  [31:0] io_interrupt_flag, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input  [4:0]  io_debug_read_address, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output [31:0] io_debug_read_data, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  input  [11:0] io_csr_debug_read_address, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output [31:0] io_csr_debug_read_data, // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
  output [31:0] io_bus_address // @[4-soc/src/main/scala/riscv/core/CPU.scala 14:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  cpu_clock; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_reset; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [31:0] cpu_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [31:0] cpu_io_instruction; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_instruction_valid; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [31:0] cpu_io_memory_bundle_address; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_memory_bundle_read; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [31:0] cpu_io_memory_bundle_read_data; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_memory_bundle_read_valid; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_memory_bundle_write; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [31:0] cpu_io_memory_bundle_write_data; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_memory_bundle_write_strobe_0; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_memory_bundle_write_strobe_1; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_memory_bundle_write_strobe_2; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_memory_bundle_write_strobe_3; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_memory_bundle_write_valid; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_memory_bundle_request; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  cpu_io_memory_bundle_granted; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [2:0] cpu_io_device_select; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [31:0] cpu_io_interrupt_flag; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [4:0] cpu_io_debug_read_address; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [31:0] cpu_io_debug_read_data; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [11:0] cpu_io_csr_debug_read_address; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire [31:0] cpu_io_csr_debug_read_data; // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
  wire  axi_master_clock; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_reset; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire [31:0] axi_master_io_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire [31:0] axi_master_io_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire [3:0] axi_master_io_channels_write_data_channel_WSTRB; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire [31:0] axi_master_io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire [31:0] axi_master_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire [31:0] axi_master_io_bundle_address; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_bundle_read; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_bundle_write; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire [31:0] axi_master_io_bundle_read_data; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire [31:0] axi_master_io_bundle_write_data; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_bundle_write_strobe_0; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_bundle_write_strobe_1; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_bundle_write_strobe_2; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_bundle_write_strobe_3; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_bundle_busy; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_bundle_read_valid; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire  axi_master_io_bundle_write_valid; // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
  wire [31:0] full_bus_address = {cpu_io_device_select,cpu_io_memory_bundle_address[28:0]}; // @[4-soc/src/main/scala/riscv/core/CPU.scala 29:51]
  wire  _cpu_io_memory_bundle_granted_T = ~axi_master_io_bundle_busy; // @[4-soc/src/main/scala/riscv/core/CPU.scala 44:51]
  reg [31:0] bus_address_reg; // @[4-soc/src/main/scala/riscv/core/CPU.scala 69:37]
  wire  _start_bus_transaction_T_1 = _cpu_io_memory_bundle_granted_T & cpu_io_memory_bundle_request; // @[4-soc/src/main/scala/riscv/core/CPU.scala 75:36]
  wire  _start_bus_transaction_T_2 = cpu_io_memory_bundle_read | cpu_io_memory_bundle_write; // @[4-soc/src/main/scala/riscv/core/CPU.scala 77:38]
  wire  start_bus_transaction = _start_bus_transaction_T_1 & _start_bus_transaction_T_2; // @[4-soc/src/main/scala/riscv/core/CPU.scala 76:40]
  PipelinedCPU cpu ( // @[4-soc/src/main/scala/riscv/core/CPU.scala 18:23]
    .clock(cpu_clock),
    .reset(cpu_reset),
    .io_instruction_address(cpu_io_instruction_address),
    .io_instruction(cpu_io_instruction),
    .io_instruction_valid(cpu_io_instruction_valid),
    .io_memory_bundle_address(cpu_io_memory_bundle_address),
    .io_memory_bundle_read(cpu_io_memory_bundle_read),
    .io_memory_bundle_read_data(cpu_io_memory_bundle_read_data),
    .io_memory_bundle_read_valid(cpu_io_memory_bundle_read_valid),
    .io_memory_bundle_write(cpu_io_memory_bundle_write),
    .io_memory_bundle_write_data(cpu_io_memory_bundle_write_data),
    .io_memory_bundle_write_strobe_0(cpu_io_memory_bundle_write_strobe_0),
    .io_memory_bundle_write_strobe_1(cpu_io_memory_bundle_write_strobe_1),
    .io_memory_bundle_write_strobe_2(cpu_io_memory_bundle_write_strobe_2),
    .io_memory_bundle_write_strobe_3(cpu_io_memory_bundle_write_strobe_3),
    .io_memory_bundle_write_valid(cpu_io_memory_bundle_write_valid),
    .io_memory_bundle_request(cpu_io_memory_bundle_request),
    .io_memory_bundle_granted(cpu_io_memory_bundle_granted),
    .io_device_select(cpu_io_device_select),
    .io_interrupt_flag(cpu_io_interrupt_flag),
    .io_debug_read_address(cpu_io_debug_read_address),
    .io_debug_read_data(cpu_io_debug_read_data),
    .io_csr_debug_read_address(cpu_io_csr_debug_read_address),
    .io_csr_debug_read_data(cpu_io_csr_debug_read_data)
  );
  AXI4LiteMaster axi_master ( // @[4-soc/src/main/scala/riscv/core/CPU.scala 26:30]
    .clock(axi_master_clock),
    .reset(axi_master_reset),
    .io_channels_write_address_channel_AWVALID(axi_master_io_channels_write_address_channel_AWVALID),
    .io_channels_write_address_channel_AWREADY(axi_master_io_channels_write_address_channel_AWREADY),
    .io_channels_write_address_channel_AWADDR(axi_master_io_channels_write_address_channel_AWADDR),
    .io_channels_write_data_channel_WVALID(axi_master_io_channels_write_data_channel_WVALID),
    .io_channels_write_data_channel_WREADY(axi_master_io_channels_write_data_channel_WREADY),
    .io_channels_write_data_channel_WDATA(axi_master_io_channels_write_data_channel_WDATA),
    .io_channels_write_data_channel_WSTRB(axi_master_io_channels_write_data_channel_WSTRB),
    .io_channels_write_response_channel_BVALID(axi_master_io_channels_write_response_channel_BVALID),
    .io_channels_write_response_channel_BREADY(axi_master_io_channels_write_response_channel_BREADY),
    .io_channels_read_address_channel_ARVALID(axi_master_io_channels_read_address_channel_ARVALID),
    .io_channels_read_address_channel_ARREADY(axi_master_io_channels_read_address_channel_ARREADY),
    .io_channels_read_address_channel_ARADDR(axi_master_io_channels_read_address_channel_ARADDR),
    .io_channels_read_data_channel_RVALID(axi_master_io_channels_read_data_channel_RVALID),
    .io_channels_read_data_channel_RREADY(axi_master_io_channels_read_data_channel_RREADY),
    .io_channels_read_data_channel_RDATA(axi_master_io_channels_read_data_channel_RDATA),
    .io_bundle_address(axi_master_io_bundle_address),
    .io_bundle_read(axi_master_io_bundle_read),
    .io_bundle_write(axi_master_io_bundle_write),
    .io_bundle_read_data(axi_master_io_bundle_read_data),
    .io_bundle_write_data(axi_master_io_bundle_write_data),
    .io_bundle_write_strobe_0(axi_master_io_bundle_write_strobe_0),
    .io_bundle_write_strobe_1(axi_master_io_bundle_write_strobe_1),
    .io_bundle_write_strobe_2(axi_master_io_bundle_write_strobe_2),
    .io_bundle_write_strobe_3(axi_master_io_bundle_write_strobe_3),
    .io_bundle_busy(axi_master_io_bundle_busy),
    .io_bundle_read_valid(axi_master_io_bundle_read_valid),
    .io_bundle_write_valid(axi_master_io_bundle_write_valid)
  );
  assign io_instruction_address = cpu_io_instruction_address; // @[4-soc/src/main/scala/riscv/core/CPU.scala 21:32]
  assign io_axi4_channels_write_address_channel_AWVALID = axi_master_io_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign io_axi4_channels_write_address_channel_AWADDR = axi_master_io_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign io_axi4_channels_write_data_channel_WVALID = axi_master_io_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign io_axi4_channels_write_data_channel_WDATA = axi_master_io_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign io_axi4_channels_write_data_channel_WSTRB = axi_master_io_channels_write_data_channel_WSTRB; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign io_axi4_channels_write_response_channel_BREADY = axi_master_io_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign io_axi4_channels_read_address_channel_ARVALID = axi_master_io_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign io_axi4_channels_read_address_channel_ARADDR = axi_master_io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign io_axi4_channels_read_data_channel_RREADY = axi_master_io_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign io_debug_read_data = cpu_io_debug_read_data; // @[4-soc/src/main/scala/riscv/core/CPU.scala 102:33]
  assign io_csr_debug_read_data = cpu_io_csr_debug_read_data; // @[4-soc/src/main/scala/riscv/core/CPU.scala 105:37]
  assign io_bus_address = bus_address_reg; // @[4-soc/src/main/scala/riscv/core/CPU.scala 83:22]
  assign cpu_clock = clock;
  assign cpu_reset = reset;
  assign cpu_io_instruction = io_instruction; // @[4-soc/src/main/scala/riscv/core/CPU.scala 22:32]
  assign cpu_io_instruction_valid = io_instruction_valid; // @[4-soc/src/main/scala/riscv/core/CPU.scala 23:32]
  assign cpu_io_memory_bundle_read_data = axi_master_io_bundle_read_data; // @[4-soc/src/main/scala/riscv/core/CPU.scala 39:48]
  assign cpu_io_memory_bundle_read_valid = axi_master_io_bundle_read_valid; // @[4-soc/src/main/scala/riscv/core/CPU.scala 40:48]
  assign cpu_io_memory_bundle_write_valid = axi_master_io_bundle_write_valid; // @[4-soc/src/main/scala/riscv/core/CPU.scala 41:48]
  assign cpu_io_memory_bundle_granted = ~axi_master_io_bundle_busy; // @[4-soc/src/main/scala/riscv/core/CPU.scala 44:51]
  assign cpu_io_interrupt_flag = io_interrupt_flag; // @[4-soc/src/main/scala/riscv/core/CPU.scala 98:29]
  assign cpu_io_debug_read_address = io_debug_read_address; // @[4-soc/src/main/scala/riscv/core/CPU.scala 101:33]
  assign cpu_io_csr_debug_read_address = io_csr_debug_read_address; // @[4-soc/src/main/scala/riscv/core/CPU.scala 104:37]
  assign axi_master_clock = clock;
  assign axi_master_reset = reset;
  assign axi_master_io_channels_write_address_channel_AWREADY = io_axi4_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign axi_master_io_channels_write_data_channel_WREADY = io_axi4_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign axi_master_io_channels_write_response_channel_BVALID = io_axi4_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign axi_master_io_channels_read_address_channel_ARREADY = io_axi4_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign axi_master_io_channels_read_data_channel_RVALID = io_axi4_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign axi_master_io_channels_read_data_channel_RDATA = io_axi4_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/riscv/core/CPU.scala 47:24]
  assign axi_master_io_bundle_address = {cpu_io_device_select,cpu_io_memory_bundle_address[28:0]}; // @[4-soc/src/main/scala/riscv/core/CPU.scala 29:51]
  assign axi_master_io_bundle_read = cpu_io_memory_bundle_request & cpu_io_memory_bundle_read; // @[4-soc/src/main/scala/riscv/core/CPU.scala 34:73]
  assign axi_master_io_bundle_write = cpu_io_memory_bundle_request & cpu_io_memory_bundle_write; // @[4-soc/src/main/scala/riscv/core/CPU.scala 35:73]
  assign axi_master_io_bundle_write_data = cpu_io_memory_bundle_write_data; // @[4-soc/src/main/scala/riscv/core/CPU.scala 36:41]
  assign axi_master_io_bundle_write_strobe_0 = cpu_io_memory_bundle_write_strobe_0; // @[4-soc/src/main/scala/riscv/core/CPU.scala 37:41]
  assign axi_master_io_bundle_write_strobe_1 = cpu_io_memory_bundle_write_strobe_1; // @[4-soc/src/main/scala/riscv/core/CPU.scala 37:41]
  assign axi_master_io_bundle_write_strobe_2 = cpu_io_memory_bundle_write_strobe_2; // @[4-soc/src/main/scala/riscv/core/CPU.scala 37:41]
  assign axi_master_io_bundle_write_strobe_3 = cpu_io_memory_bundle_write_strobe_3; // @[4-soc/src/main/scala/riscv/core/CPU.scala 37:41]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/riscv/core/CPU.scala 69:37]
      bus_address_reg <= 32'h0; // @[4-soc/src/main/scala/riscv/core/CPU.scala 69:37]
    end else if (start_bus_transaction) begin // @[4-soc/src/main/scala/riscv/core/CPU.scala 79:35]
      bus_address_reg <= full_bus_address; // @[4-soc/src/main/scala/riscv/core/CPU.scala 80:25]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  bus_address_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DummySlave(
  input   clock,
  input   reset,
  input   io_channels_write_address_channel_AWVALID, // @[4-soc/src/main/scala/peripheral/DummySlave.scala 26:14]
  output  io_channels_write_address_channel_AWREADY, // @[4-soc/src/main/scala/peripheral/DummySlave.scala 26:14]
  input   io_channels_write_data_channel_WVALID, // @[4-soc/src/main/scala/peripheral/DummySlave.scala 26:14]
  output  io_channels_write_data_channel_WREADY, // @[4-soc/src/main/scala/peripheral/DummySlave.scala 26:14]
  output  io_channels_write_response_channel_BVALID, // @[4-soc/src/main/scala/peripheral/DummySlave.scala 26:14]
  input   io_channels_write_response_channel_BREADY, // @[4-soc/src/main/scala/peripheral/DummySlave.scala 26:14]
  input   io_channels_read_address_channel_ARVALID, // @[4-soc/src/main/scala/peripheral/DummySlave.scala 26:14]
  output  io_channels_read_address_channel_ARREADY, // @[4-soc/src/main/scala/peripheral/DummySlave.scala 26:14]
  output  io_channels_read_data_channel_RVALID, // @[4-soc/src/main/scala/peripheral/DummySlave.scala 26:14]
  input   io_channels_read_data_channel_RREADY // @[4-soc/src/main/scala/peripheral/DummySlave.scala 26:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg  read_pending; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 33:30]
  reg  write_pending; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 34:30]
  reg  write_data_ok; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 35:30]
  wire  _GEN_0 = io_channels_read_address_channel_ARVALID & io_channels_read_address_channel_ARREADY | read_pending; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 40:94 41:18 33:30]
  wire  _GEN_2 = io_channels_write_address_channel_AWVALID & io_channels_write_address_channel_AWREADY | write_pending; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 56:96 57:19 34:30]
  wire  _GEN_3 = write_pending & io_channels_write_data_channel_WVALID & io_channels_write_data_channel_WREADY |
    write_data_ok; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 63:105 64:19 35:30]
  assign io_channels_write_address_channel_AWREADY = ~write_pending; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 54:48]
  assign io_channels_write_data_channel_WREADY = write_pending & ~write_data_ok; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 61:58]
  assign io_channels_write_response_channel_BVALID = write_data_ok; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 68:45]
  assign io_channels_read_address_channel_ARREADY = ~read_pending; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 38:47]
  assign io_channels_read_data_channel_RVALID = read_pending; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 45:40]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/peripheral/DummySlave.scala 33:30]
      read_pending <= 1'h0; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 33:30]
    end else if (read_pending & io_channels_read_data_channel_RREADY) begin // @[4-soc/src/main/scala/peripheral/DummySlave.scala 49:62]
      read_pending <= 1'h0; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 50:18]
    end else begin
      read_pending <= _GEN_0;
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/DummySlave.scala 34:30]
      write_pending <= 1'h0; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 34:30]
    end else if (write_data_ok & io_channels_write_response_channel_BREADY) begin // @[4-soc/src/main/scala/peripheral/DummySlave.scala 71:68]
      write_pending <= 1'h0; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 72:19]
    end else begin
      write_pending <= _GEN_2;
    end
    if (reset) begin // @[4-soc/src/main/scala/peripheral/DummySlave.scala 35:30]
      write_data_ok <= 1'h0; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 35:30]
    end else if (write_data_ok & io_channels_write_response_channel_BREADY) begin // @[4-soc/src/main/scala/peripheral/DummySlave.scala 71:68]
      write_data_ok <= 1'h0; // @[4-soc/src/main/scala/peripheral/DummySlave.scala 73:19]
    end else begin
      write_data_ok <= _GEN_3;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  read_pending = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  write_pending = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  write_data_ok = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BusSwitch(
  input         clock,
  input         reset,
  input  [31:0] io_address, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_0_write_address_channel_AWVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_0_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [31:0] io_slaves_0_write_address_channel_AWADDR, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_0_write_data_channel_WVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_0_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [31:0] io_slaves_0_write_data_channel_WDATA, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [3:0]  io_slaves_0_write_data_channel_WSTRB, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_0_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_0_write_response_channel_BREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_0_read_address_channel_ARVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_0_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [31:0] io_slaves_0_read_address_channel_ARADDR, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_0_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_0_read_data_channel_RREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input  [31:0] io_slaves_0_read_data_channel_RDATA, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_1_write_address_channel_AWVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_1_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [31:0] io_slaves_1_write_address_channel_AWADDR, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_1_write_data_channel_WVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_1_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [31:0] io_slaves_1_write_data_channel_WDATA, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_1_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_1_write_response_channel_BREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_1_read_address_channel_ARVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_1_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [31:0] io_slaves_1_read_address_channel_ARADDR, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_1_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_1_read_data_channel_RREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input  [31:0] io_slaves_1_read_data_channel_RDATA, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_2_write_address_channel_AWVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_2_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [31:0] io_slaves_2_write_address_channel_AWADDR, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_2_write_data_channel_WVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_2_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [31:0] io_slaves_2_write_data_channel_WDATA, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_2_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_2_write_response_channel_BREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_2_read_address_channel_ARVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_2_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [31:0] io_slaves_2_read_address_channel_ARADDR, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_2_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_2_read_data_channel_RREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input  [31:0] io_slaves_2_read_data_channel_RDATA, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_3_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_3_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_3_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_3_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_3_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_4_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_4_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_4_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_4_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_4_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_5_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_5_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_5_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_5_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_5_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_6_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_6_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_6_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_6_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_6_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_7_write_address_channel_AWVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_7_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_7_write_data_channel_WVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_7_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_7_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_7_write_response_channel_BREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_7_read_address_channel_ARVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_7_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_slaves_7_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_slaves_7_read_data_channel_RREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_master_write_address_channel_AWVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_master_write_address_channel_AWREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input  [31:0] io_master_write_address_channel_AWADDR, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_master_write_data_channel_WVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_master_write_data_channel_WREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input  [31:0] io_master_write_data_channel_WDATA, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input  [3:0]  io_master_write_data_channel_WSTRB, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_master_write_response_channel_BVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_master_write_response_channel_BREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_master_read_address_channel_ARVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_master_read_address_channel_ARREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input  [31:0] io_master_read_address_channel_ARADDR, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output        io_master_read_data_channel_RVALID, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  input         io_master_read_data_channel_RREADY, // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
  output [31:0] io_master_read_data_channel_RDATA // @[4-soc/src/main/scala/bus/BusSwitch.scala 43:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [2:0] index = io_address[31:29]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 49:25]
  wire [7:0] sel = 8'h1 << index; // @[src/main/scala/chisel3/util/OneHot.scala 65:12]
  reg [7:0] read_sel; // @[4-soc/src/main/scala/bus/BusSwitch.scala 55:26]
  reg [7:0] write_sel; // @[4-soc/src/main/scala/bus/BusSwitch.scala 56:26]
  wire  hit = sel[0]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 78:18]
  wire  hit_1 = sel[1]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 78:18]
  wire  hit_2 = sel[2]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 78:18]
  wire  hit_7 = sel[7]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 78:18]
  wire [31:0] _io_master_read_data_channel_RDATA_T_8 = read_sel[0] ? io_slaves_0_read_data_channel_RDATA : 32'h0; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_9 = read_sel[1] ? io_slaves_1_read_data_channel_RDATA : 32'h0; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_10 = read_sel[2] ? io_slaves_2_read_data_channel_RDATA : 32'h0; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_11 = read_sel[3] ? 32'hdeadbeef : 32'h0; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_12 = read_sel[4] ? 32'hdeadbeef : 32'h0; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_13 = read_sel[5] ? 32'hdeadbeef : 32'h0; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_14 = read_sel[6] ? 32'hdeadbeef : 32'h0; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_15 = read_sel[7] ? 32'hdeadbeef : 32'h0; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_16 = _io_master_read_data_channel_RDATA_T_8 |
    _io_master_read_data_channel_RDATA_T_9; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_17 = _io_master_read_data_channel_RDATA_T_16 |
    _io_master_read_data_channel_RDATA_T_10; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_18 = _io_master_read_data_channel_RDATA_T_17 |
    _io_master_read_data_channel_RDATA_T_11; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_19 = _io_master_read_data_channel_RDATA_T_18 |
    _io_master_read_data_channel_RDATA_T_12; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_20 = _io_master_read_data_channel_RDATA_T_19 |
    _io_master_read_data_channel_RDATA_T_13; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  wire [31:0] _io_master_read_data_channel_RDATA_T_21 = _io_master_read_data_channel_RDATA_T_20 |
    _io_master_read_data_channel_RDATA_T_14; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  assign io_slaves_0_write_address_channel_AWVALID = io_master_write_address_channel_AWVALID & hit; // @[4-soc/src/main/scala/bus/BusSwitch.scala 81:91]
  assign io_slaves_0_write_address_channel_AWADDR = io_master_write_address_channel_AWADDR; // @[4-soc/src/main/scala/bus/BusSwitch.scala 82:48]
  assign io_slaves_0_write_data_channel_WVALID = io_master_write_data_channel_WVALID & hit; // @[4-soc/src/main/scala/bus/BusSwitch.scala 86:83]
  assign io_slaves_0_write_data_channel_WDATA = io_master_write_data_channel_WDATA; // @[4-soc/src/main/scala/bus/BusSwitch.scala 87:44]
  assign io_slaves_0_write_data_channel_WSTRB = io_master_write_data_channel_WSTRB; // @[4-soc/src/main/scala/bus/BusSwitch.scala 88:44]
  assign io_slaves_0_write_response_channel_BREADY = io_master_write_response_channel_BREADY & write_sel[0]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 91:91]
  assign io_slaves_0_read_address_channel_ARVALID = io_master_read_address_channel_ARVALID & hit; // @[4-soc/src/main/scala/bus/BusSwitch.scala 94:89]
  assign io_slaves_0_read_address_channel_ARADDR = io_master_read_address_channel_ARADDR; // @[4-soc/src/main/scala/bus/BusSwitch.scala 95:47]
  assign io_slaves_0_read_data_channel_RREADY = io_master_read_data_channel_RREADY & read_sel[0]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 99:81]
  assign io_slaves_1_write_address_channel_AWVALID = io_master_write_address_channel_AWVALID & hit_1; // @[4-soc/src/main/scala/bus/BusSwitch.scala 81:91]
  assign io_slaves_1_write_address_channel_AWADDR = io_master_write_address_channel_AWADDR; // @[4-soc/src/main/scala/bus/BusSwitch.scala 82:48]
  assign io_slaves_1_write_data_channel_WVALID = io_master_write_data_channel_WVALID & hit_1; // @[4-soc/src/main/scala/bus/BusSwitch.scala 86:83]
  assign io_slaves_1_write_data_channel_WDATA = io_master_write_data_channel_WDATA; // @[4-soc/src/main/scala/bus/BusSwitch.scala 87:44]
  assign io_slaves_1_write_response_channel_BREADY = io_master_write_response_channel_BREADY & write_sel[1]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 91:91]
  assign io_slaves_1_read_address_channel_ARVALID = io_master_read_address_channel_ARVALID & hit_1; // @[4-soc/src/main/scala/bus/BusSwitch.scala 94:89]
  assign io_slaves_1_read_address_channel_ARADDR = io_master_read_address_channel_ARADDR; // @[4-soc/src/main/scala/bus/BusSwitch.scala 95:47]
  assign io_slaves_1_read_data_channel_RREADY = io_master_read_data_channel_RREADY & read_sel[1]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 99:81]
  assign io_slaves_2_write_address_channel_AWVALID = io_master_write_address_channel_AWVALID & hit_2; // @[4-soc/src/main/scala/bus/BusSwitch.scala 81:91]
  assign io_slaves_2_write_address_channel_AWADDR = io_master_write_address_channel_AWADDR; // @[4-soc/src/main/scala/bus/BusSwitch.scala 82:48]
  assign io_slaves_2_write_data_channel_WVALID = io_master_write_data_channel_WVALID & hit_2; // @[4-soc/src/main/scala/bus/BusSwitch.scala 86:83]
  assign io_slaves_2_write_data_channel_WDATA = io_master_write_data_channel_WDATA; // @[4-soc/src/main/scala/bus/BusSwitch.scala 87:44]
  assign io_slaves_2_write_response_channel_BREADY = io_master_write_response_channel_BREADY & write_sel[2]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 91:91]
  assign io_slaves_2_read_address_channel_ARVALID = io_master_read_address_channel_ARVALID & hit_2; // @[4-soc/src/main/scala/bus/BusSwitch.scala 94:89]
  assign io_slaves_2_read_address_channel_ARADDR = io_master_read_address_channel_ARADDR; // @[4-soc/src/main/scala/bus/BusSwitch.scala 95:47]
  assign io_slaves_2_read_data_channel_RREADY = io_master_read_data_channel_RREADY & read_sel[2]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 99:81]
  assign io_slaves_7_write_address_channel_AWVALID = io_master_write_address_channel_AWVALID & hit_7; // @[4-soc/src/main/scala/bus/BusSwitch.scala 81:91]
  assign io_slaves_7_write_data_channel_WVALID = io_master_write_data_channel_WVALID & hit_7; // @[4-soc/src/main/scala/bus/BusSwitch.scala 86:83]
  assign io_slaves_7_write_response_channel_BREADY = io_master_write_response_channel_BREADY & write_sel[7]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 91:91]
  assign io_slaves_7_read_address_channel_ARVALID = io_master_read_address_channel_ARVALID & hit_7; // @[4-soc/src/main/scala/bus/BusSwitch.scala 94:89]
  assign io_slaves_7_read_data_channel_RREADY = io_master_read_data_channel_RREADY & read_sel[7]; // @[4-soc/src/main/scala/bus/BusSwitch.scala 99:81]
  assign io_master_write_address_channel_AWREADY = hit & io_slaves_0_write_address_channel_AWREADY | hit_1 &
    io_slaves_1_write_address_channel_AWREADY | hit_2 & io_slaves_2_write_address_channel_AWREADY | sel[3] &
    io_slaves_3_write_address_channel_AWREADY | sel[4] & io_slaves_4_write_address_channel_AWREADY | sel[5] &
    io_slaves_5_write_address_channel_AWREADY | sel[6] & io_slaves_6_write_address_channel_AWREADY | hit_7 &
    io_slaves_7_write_address_channel_AWREADY; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  assign io_master_write_data_channel_WREADY = hit & io_slaves_0_write_data_channel_WREADY | hit_1 &
    io_slaves_1_write_data_channel_WREADY | hit_2 & io_slaves_2_write_data_channel_WREADY | sel[3] &
    io_slaves_3_write_data_channel_WREADY | sel[4] & io_slaves_4_write_data_channel_WREADY | sel[5] &
    io_slaves_5_write_data_channel_WREADY | sel[6] & io_slaves_6_write_data_channel_WREADY | hit_7 &
    io_slaves_7_write_data_channel_WREADY; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  assign io_master_write_response_channel_BVALID = write_sel[0] & io_slaves_0_write_response_channel_BVALID | write_sel[
    1] & io_slaves_1_write_response_channel_BVALID | write_sel[2] & io_slaves_2_write_response_channel_BVALID |
    write_sel[3] & io_slaves_3_write_response_channel_BVALID | write_sel[4] & io_slaves_4_write_response_channel_BVALID
     | write_sel[5] & io_slaves_5_write_response_channel_BVALID | write_sel[6] &
    io_slaves_6_write_response_channel_BVALID | write_sel[7] & io_slaves_7_write_response_channel_BVALID; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  assign io_master_read_address_channel_ARREADY = hit & io_slaves_0_read_address_channel_ARREADY | hit_1 &
    io_slaves_1_read_address_channel_ARREADY | hit_2 & io_slaves_2_read_address_channel_ARREADY | sel[3] &
    io_slaves_3_read_address_channel_ARREADY | sel[4] & io_slaves_4_read_address_channel_ARREADY | sel[5] &
    io_slaves_5_read_address_channel_ARREADY | sel[6] & io_slaves_6_read_address_channel_ARREADY | hit_7 &
    io_slaves_7_read_address_channel_ARREADY; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  assign io_master_read_data_channel_RVALID = read_sel[0] & io_slaves_0_read_data_channel_RVALID | read_sel[1] &
    io_slaves_1_read_data_channel_RVALID | read_sel[2] & io_slaves_2_read_data_channel_RVALID | read_sel[3] &
    io_slaves_3_read_data_channel_RVALID | read_sel[4] & io_slaves_4_read_data_channel_RVALID | read_sel[5] &
    io_slaves_5_read_data_channel_RVALID | read_sel[6] & io_slaves_6_read_data_channel_RVALID | read_sel[7] &
    io_slaves_7_read_data_channel_RVALID; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  assign io_master_read_data_channel_RDATA = _io_master_read_data_channel_RDATA_T_21 |
    _io_master_read_data_channel_RDATA_T_15; // @[src/main/scala/chisel3/util/Mux.scala 30:73]
  always @(posedge clock) begin
    if (reset) begin // @[4-soc/src/main/scala/bus/BusSwitch.scala 55:26]
      read_sel <= 8'h0; // @[4-soc/src/main/scala/bus/BusSwitch.scala 55:26]
    end else if (io_master_read_address_channel_ARVALID) begin // @[4-soc/src/main/scala/bus/BusSwitch.scala 61:48]
      read_sel <= sel; // @[4-soc/src/main/scala/bus/BusSwitch.scala 62:14]
    end else if (io_master_read_data_channel_RVALID & io_master_read_data_channel_RREADY) begin // @[4-soc/src/main/scala/bus/BusSwitch.scala 63:88]
      read_sel <= 8'h0; // @[4-soc/src/main/scala/bus/BusSwitch.scala 64:14]
    end
    if (reset) begin // @[4-soc/src/main/scala/bus/BusSwitch.scala 56:26]
      write_sel <= 8'h0; // @[4-soc/src/main/scala/bus/BusSwitch.scala 56:26]
    end else if (io_master_write_address_channel_AWVALID | io_master_write_data_channel_WVALID) begin // @[4-soc/src/main/scala/bus/BusSwitch.scala 69:88]
      write_sel <= sel; // @[4-soc/src/main/scala/bus/BusSwitch.scala 70:15]
    end else if (io_master_write_response_channel_BVALID & io_master_write_response_channel_BREADY) begin // @[4-soc/src/main/scala/bus/BusSwitch.scala 71:98]
      write_sel <= 8'h0; // @[4-soc/src/main/scala/bus/BusSwitch.scala 72:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  read_sel = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  write_sel = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Top(
  input         clock,
  input         reset,
  input         io_signal_interrupt, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output [31:0] io_instruction_address, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  input  [31:0] io_instruction, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  input         io_instruction_valid, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output [31:0] io_mem_slave_address, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_mem_slave_read, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  input  [31:0] io_mem_slave_read_data, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  input         io_mem_slave_read_valid, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_mem_slave_write, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output [31:0] io_mem_slave_write_data, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_mem_slave_write_strobe_0, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_mem_slave_write_strobe_1, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_mem_slave_write_strobe_2, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_mem_slave_write_strobe_3, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  input         io_vga_pixclk, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_vga_hsync, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_vga_vsync, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output [5:0]  io_vga_rrggbb, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_vga_activevideo, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output [9:0]  io_vga_x_pos, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output [9:0]  io_vga_y_pos, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_uart_txd, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  input         io_uart_rxd, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output        io_uart_interrupt, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  input  [4:0]  io_cpu_debug_read_address, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output [31:0] io_cpu_debug_read_data, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  input  [11:0] io_cpu_csr_debug_read_address, // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
  output [31:0] io_cpu_csr_debug_read_data // @[4-soc/src/main/scala/board/verilator/Top.scala 20:14]
);
  wire  mem_slave_clock; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_reset; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire [31:0] mem_slave_io_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire [31:0] mem_slave_io_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire [3:0] mem_slave_io_channels_write_data_channel_WSTRB; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire [31:0] mem_slave_io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire [31:0] mem_slave_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire [31:0] mem_slave_io_bundle_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_bundle_read; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire [31:0] mem_slave_io_bundle_read_data; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_bundle_read_valid; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_bundle_write; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire [31:0] mem_slave_io_bundle_write_data; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_bundle_write_strobe_0; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_bundle_write_strobe_1; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_bundle_write_strobe_2; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  mem_slave_io_bundle_write_strobe_3; // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
  wire  vga_clock; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_reset; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire [7:0] vga_io_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire [31:0] vga_io_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire [7:0] vga_io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire [31:0] vga_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_pixClock; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_hsync; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_vsync; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire [5:0] vga_io_rrggbb; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  vga_io_activevideo; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire [9:0] vga_io_x_pos; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire [9:0] vga_io_y_pos; // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
  wire  uart_clock; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_reset; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire [7:0] uart_io_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire [31:0] uart_io_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire [7:0] uart_io_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire [31:0] uart_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_rxd; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_txd; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  uart_io_signal_interrupt; // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
  wire  cpu_clock; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_reset; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [31:0] cpu_io_instruction_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [31:0] cpu_io_instruction; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_instruction_valid; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_axi4_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_axi4_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [31:0] cpu_io_axi4_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_axi4_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_axi4_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [31:0] cpu_io_axi4_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [3:0] cpu_io_axi4_channels_write_data_channel_WSTRB; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_axi4_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_axi4_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_axi4_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_axi4_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [31:0] cpu_io_axi4_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_axi4_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  cpu_io_axi4_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [31:0] cpu_io_axi4_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [31:0] cpu_io_interrupt_flag; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [4:0] cpu_io_debug_read_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [31:0] cpu_io_debug_read_data; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [11:0] cpu_io_csr_debug_read_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [31:0] cpu_io_csr_debug_read_data; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire [31:0] cpu_io_bus_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
  wire  dummy_clock; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_reset; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_io_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_io_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_io_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_io_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  dummy_io_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
  wire  bus_switch_clock; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_reset; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_0_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_0_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_0_write_address_channel_AWADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_0_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_0_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_0_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [3:0] bus_switch_io_slaves_0_write_data_channel_WSTRB; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_0_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_0_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_0_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_0_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_0_read_address_channel_ARADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_0_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_0_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_0_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_1_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_1_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_1_write_address_channel_AWADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_1_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_1_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_1_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_1_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_1_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_1_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_1_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_1_read_address_channel_ARADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_1_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_1_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_1_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_2_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_2_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_2_write_address_channel_AWADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_2_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_2_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_2_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_2_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_2_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_2_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_2_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_2_read_address_channel_ARADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_2_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_2_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_slaves_2_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_3_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_3_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_3_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_3_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_3_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_4_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_4_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_4_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_4_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_4_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_5_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_5_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_5_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_5_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_5_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_6_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_6_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_6_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_6_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_6_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_7_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_7_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_7_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_7_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_7_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_7_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_7_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_7_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_7_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_slaves_7_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_master_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_master_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_master_write_address_channel_AWADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_master_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_master_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_master_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [3:0] bus_switch_io_master_write_data_channel_WSTRB; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_master_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_master_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_master_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_master_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_master_read_address_channel_ARADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_master_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire  bus_switch_io_master_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  wire [31:0] bus_switch_io_master_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
  AXI4LiteSlave mem_slave ( // @[4-soc/src/main/scala/board/verilator/Top.scala 51:25]
    .clock(mem_slave_clock),
    .reset(mem_slave_reset),
    .io_channels_write_address_channel_AWVALID(mem_slave_io_channels_write_address_channel_AWVALID),
    .io_channels_write_address_channel_AWREADY(mem_slave_io_channels_write_address_channel_AWREADY),
    .io_channels_write_address_channel_AWADDR(mem_slave_io_channels_write_address_channel_AWADDR),
    .io_channels_write_data_channel_WVALID(mem_slave_io_channels_write_data_channel_WVALID),
    .io_channels_write_data_channel_WREADY(mem_slave_io_channels_write_data_channel_WREADY),
    .io_channels_write_data_channel_WDATA(mem_slave_io_channels_write_data_channel_WDATA),
    .io_channels_write_data_channel_WSTRB(mem_slave_io_channels_write_data_channel_WSTRB),
    .io_channels_write_response_channel_BVALID(mem_slave_io_channels_write_response_channel_BVALID),
    .io_channels_write_response_channel_BREADY(mem_slave_io_channels_write_response_channel_BREADY),
    .io_channels_read_address_channel_ARVALID(mem_slave_io_channels_read_address_channel_ARVALID),
    .io_channels_read_address_channel_ARREADY(mem_slave_io_channels_read_address_channel_ARREADY),
    .io_channels_read_address_channel_ARADDR(mem_slave_io_channels_read_address_channel_ARADDR),
    .io_channels_read_data_channel_RVALID(mem_slave_io_channels_read_data_channel_RVALID),
    .io_channels_read_data_channel_RREADY(mem_slave_io_channels_read_data_channel_RREADY),
    .io_channels_read_data_channel_RDATA(mem_slave_io_channels_read_data_channel_RDATA),
    .io_bundle_address(mem_slave_io_bundle_address),
    .io_bundle_read(mem_slave_io_bundle_read),
    .io_bundle_read_data(mem_slave_io_bundle_read_data),
    .io_bundle_read_valid(mem_slave_io_bundle_read_valid),
    .io_bundle_write(mem_slave_io_bundle_write),
    .io_bundle_write_data(mem_slave_io_bundle_write_data),
    .io_bundle_write_strobe_0(mem_slave_io_bundle_write_strobe_0),
    .io_bundle_write_strobe_1(mem_slave_io_bundle_write_strobe_1),
    .io_bundle_write_strobe_2(mem_slave_io_bundle_write_strobe_2),
    .io_bundle_write_strobe_3(mem_slave_io_bundle_write_strobe_3)
  );
  VGA vga ( // @[4-soc/src/main/scala/board/verilator/Top.scala 55:19]
    .clock(vga_clock),
    .reset(vga_reset),
    .io_channels_write_address_channel_AWVALID(vga_io_channels_write_address_channel_AWVALID),
    .io_channels_write_address_channel_AWREADY(vga_io_channels_write_address_channel_AWREADY),
    .io_channels_write_address_channel_AWADDR(vga_io_channels_write_address_channel_AWADDR),
    .io_channels_write_data_channel_WVALID(vga_io_channels_write_data_channel_WVALID),
    .io_channels_write_data_channel_WREADY(vga_io_channels_write_data_channel_WREADY),
    .io_channels_write_data_channel_WDATA(vga_io_channels_write_data_channel_WDATA),
    .io_channels_write_response_channel_BVALID(vga_io_channels_write_response_channel_BVALID),
    .io_channels_write_response_channel_BREADY(vga_io_channels_write_response_channel_BREADY),
    .io_channels_read_address_channel_ARVALID(vga_io_channels_read_address_channel_ARVALID),
    .io_channels_read_address_channel_ARREADY(vga_io_channels_read_address_channel_ARREADY),
    .io_channels_read_address_channel_ARADDR(vga_io_channels_read_address_channel_ARADDR),
    .io_channels_read_data_channel_RVALID(vga_io_channels_read_data_channel_RVALID),
    .io_channels_read_data_channel_RREADY(vga_io_channels_read_data_channel_RREADY),
    .io_channels_read_data_channel_RDATA(vga_io_channels_read_data_channel_RDATA),
    .io_pixClock(vga_io_pixClock),
    .io_hsync(vga_io_hsync),
    .io_vsync(vga_io_vsync),
    .io_rrggbb(vga_io_rrggbb),
    .io_activevideo(vga_io_activevideo),
    .io_x_pos(vga_io_x_pos),
    .io_y_pos(vga_io_y_pos)
  );
  Uart uart ( // @[4-soc/src/main/scala/board/verilator/Top.scala 58:20]
    .clock(uart_clock),
    .reset(uart_reset),
    .io_channels_write_address_channel_AWVALID(uart_io_channels_write_address_channel_AWVALID),
    .io_channels_write_address_channel_AWREADY(uart_io_channels_write_address_channel_AWREADY),
    .io_channels_write_address_channel_AWADDR(uart_io_channels_write_address_channel_AWADDR),
    .io_channels_write_data_channel_WVALID(uart_io_channels_write_data_channel_WVALID),
    .io_channels_write_data_channel_WREADY(uart_io_channels_write_data_channel_WREADY),
    .io_channels_write_data_channel_WDATA(uart_io_channels_write_data_channel_WDATA),
    .io_channels_write_response_channel_BVALID(uart_io_channels_write_response_channel_BVALID),
    .io_channels_write_response_channel_BREADY(uart_io_channels_write_response_channel_BREADY),
    .io_channels_read_address_channel_ARVALID(uart_io_channels_read_address_channel_ARVALID),
    .io_channels_read_address_channel_ARREADY(uart_io_channels_read_address_channel_ARREADY),
    .io_channels_read_address_channel_ARADDR(uart_io_channels_read_address_channel_ARADDR),
    .io_channels_read_data_channel_RVALID(uart_io_channels_read_data_channel_RVALID),
    .io_channels_read_data_channel_RREADY(uart_io_channels_read_data_channel_RREADY),
    .io_channels_read_data_channel_RDATA(uart_io_channels_read_data_channel_RDATA),
    .io_rxd(uart_io_rxd),
    .io_txd(uart_io_txd),
    .io_signal_interrupt(uart_io_signal_interrupt)
  );
  CPU cpu ( // @[4-soc/src/main/scala/board/verilator/Top.scala 60:27]
    .clock(cpu_clock),
    .reset(cpu_reset),
    .io_instruction_address(cpu_io_instruction_address),
    .io_instruction(cpu_io_instruction),
    .io_instruction_valid(cpu_io_instruction_valid),
    .io_axi4_channels_write_address_channel_AWVALID(cpu_io_axi4_channels_write_address_channel_AWVALID),
    .io_axi4_channels_write_address_channel_AWREADY(cpu_io_axi4_channels_write_address_channel_AWREADY),
    .io_axi4_channels_write_address_channel_AWADDR(cpu_io_axi4_channels_write_address_channel_AWADDR),
    .io_axi4_channels_write_data_channel_WVALID(cpu_io_axi4_channels_write_data_channel_WVALID),
    .io_axi4_channels_write_data_channel_WREADY(cpu_io_axi4_channels_write_data_channel_WREADY),
    .io_axi4_channels_write_data_channel_WDATA(cpu_io_axi4_channels_write_data_channel_WDATA),
    .io_axi4_channels_write_data_channel_WSTRB(cpu_io_axi4_channels_write_data_channel_WSTRB),
    .io_axi4_channels_write_response_channel_BVALID(cpu_io_axi4_channels_write_response_channel_BVALID),
    .io_axi4_channels_write_response_channel_BREADY(cpu_io_axi4_channels_write_response_channel_BREADY),
    .io_axi4_channels_read_address_channel_ARVALID(cpu_io_axi4_channels_read_address_channel_ARVALID),
    .io_axi4_channels_read_address_channel_ARREADY(cpu_io_axi4_channels_read_address_channel_ARREADY),
    .io_axi4_channels_read_address_channel_ARADDR(cpu_io_axi4_channels_read_address_channel_ARADDR),
    .io_axi4_channels_read_data_channel_RVALID(cpu_io_axi4_channels_read_data_channel_RVALID),
    .io_axi4_channels_read_data_channel_RREADY(cpu_io_axi4_channels_read_data_channel_RREADY),
    .io_axi4_channels_read_data_channel_RDATA(cpu_io_axi4_channels_read_data_channel_RDATA),
    .io_interrupt_flag(cpu_io_interrupt_flag),
    .io_debug_read_address(cpu_io_debug_read_address),
    .io_debug_read_data(cpu_io_debug_read_data),
    .io_csr_debug_read_address(cpu_io_csr_debug_read_address),
    .io_csr_debug_read_data(cpu_io_csr_debug_read_data),
    .io_bus_address(cpu_io_bus_address)
  );
  DummySlave dummy ( // @[4-soc/src/main/scala/board/verilator/Top.scala 61:27]
    .clock(dummy_clock),
    .reset(dummy_reset),
    .io_channels_write_address_channel_AWVALID(dummy_io_channels_write_address_channel_AWVALID),
    .io_channels_write_address_channel_AWREADY(dummy_io_channels_write_address_channel_AWREADY),
    .io_channels_write_data_channel_WVALID(dummy_io_channels_write_data_channel_WVALID),
    .io_channels_write_data_channel_WREADY(dummy_io_channels_write_data_channel_WREADY),
    .io_channels_write_response_channel_BVALID(dummy_io_channels_write_response_channel_BVALID),
    .io_channels_write_response_channel_BREADY(dummy_io_channels_write_response_channel_BREADY),
    .io_channels_read_address_channel_ARVALID(dummy_io_channels_read_address_channel_ARVALID),
    .io_channels_read_address_channel_ARREADY(dummy_io_channels_read_address_channel_ARREADY),
    .io_channels_read_data_channel_RVALID(dummy_io_channels_read_data_channel_RVALID),
    .io_channels_read_data_channel_RREADY(dummy_io_channels_read_data_channel_RREADY)
  );
  BusSwitch bus_switch ( // @[4-soc/src/main/scala/board/verilator/Top.scala 63:27]
    .clock(bus_switch_clock),
    .reset(bus_switch_reset),
    .io_address(bus_switch_io_address),
    .io_slaves_0_write_address_channel_AWVALID(bus_switch_io_slaves_0_write_address_channel_AWVALID),
    .io_slaves_0_write_address_channel_AWREADY(bus_switch_io_slaves_0_write_address_channel_AWREADY),
    .io_slaves_0_write_address_channel_AWADDR(bus_switch_io_slaves_0_write_address_channel_AWADDR),
    .io_slaves_0_write_data_channel_WVALID(bus_switch_io_slaves_0_write_data_channel_WVALID),
    .io_slaves_0_write_data_channel_WREADY(bus_switch_io_slaves_0_write_data_channel_WREADY),
    .io_slaves_0_write_data_channel_WDATA(bus_switch_io_slaves_0_write_data_channel_WDATA),
    .io_slaves_0_write_data_channel_WSTRB(bus_switch_io_slaves_0_write_data_channel_WSTRB),
    .io_slaves_0_write_response_channel_BVALID(bus_switch_io_slaves_0_write_response_channel_BVALID),
    .io_slaves_0_write_response_channel_BREADY(bus_switch_io_slaves_0_write_response_channel_BREADY),
    .io_slaves_0_read_address_channel_ARVALID(bus_switch_io_slaves_0_read_address_channel_ARVALID),
    .io_slaves_0_read_address_channel_ARREADY(bus_switch_io_slaves_0_read_address_channel_ARREADY),
    .io_slaves_0_read_address_channel_ARADDR(bus_switch_io_slaves_0_read_address_channel_ARADDR),
    .io_slaves_0_read_data_channel_RVALID(bus_switch_io_slaves_0_read_data_channel_RVALID),
    .io_slaves_0_read_data_channel_RREADY(bus_switch_io_slaves_0_read_data_channel_RREADY),
    .io_slaves_0_read_data_channel_RDATA(bus_switch_io_slaves_0_read_data_channel_RDATA),
    .io_slaves_1_write_address_channel_AWVALID(bus_switch_io_slaves_1_write_address_channel_AWVALID),
    .io_slaves_1_write_address_channel_AWREADY(bus_switch_io_slaves_1_write_address_channel_AWREADY),
    .io_slaves_1_write_address_channel_AWADDR(bus_switch_io_slaves_1_write_address_channel_AWADDR),
    .io_slaves_1_write_data_channel_WVALID(bus_switch_io_slaves_1_write_data_channel_WVALID),
    .io_slaves_1_write_data_channel_WREADY(bus_switch_io_slaves_1_write_data_channel_WREADY),
    .io_slaves_1_write_data_channel_WDATA(bus_switch_io_slaves_1_write_data_channel_WDATA),
    .io_slaves_1_write_response_channel_BVALID(bus_switch_io_slaves_1_write_response_channel_BVALID),
    .io_slaves_1_write_response_channel_BREADY(bus_switch_io_slaves_1_write_response_channel_BREADY),
    .io_slaves_1_read_address_channel_ARVALID(bus_switch_io_slaves_1_read_address_channel_ARVALID),
    .io_slaves_1_read_address_channel_ARREADY(bus_switch_io_slaves_1_read_address_channel_ARREADY),
    .io_slaves_1_read_address_channel_ARADDR(bus_switch_io_slaves_1_read_address_channel_ARADDR),
    .io_slaves_1_read_data_channel_RVALID(bus_switch_io_slaves_1_read_data_channel_RVALID),
    .io_slaves_1_read_data_channel_RREADY(bus_switch_io_slaves_1_read_data_channel_RREADY),
    .io_slaves_1_read_data_channel_RDATA(bus_switch_io_slaves_1_read_data_channel_RDATA),
    .io_slaves_2_write_address_channel_AWVALID(bus_switch_io_slaves_2_write_address_channel_AWVALID),
    .io_slaves_2_write_address_channel_AWREADY(bus_switch_io_slaves_2_write_address_channel_AWREADY),
    .io_slaves_2_write_address_channel_AWADDR(bus_switch_io_slaves_2_write_address_channel_AWADDR),
    .io_slaves_2_write_data_channel_WVALID(bus_switch_io_slaves_2_write_data_channel_WVALID),
    .io_slaves_2_write_data_channel_WREADY(bus_switch_io_slaves_2_write_data_channel_WREADY),
    .io_slaves_2_write_data_channel_WDATA(bus_switch_io_slaves_2_write_data_channel_WDATA),
    .io_slaves_2_write_response_channel_BVALID(bus_switch_io_slaves_2_write_response_channel_BVALID),
    .io_slaves_2_write_response_channel_BREADY(bus_switch_io_slaves_2_write_response_channel_BREADY),
    .io_slaves_2_read_address_channel_ARVALID(bus_switch_io_slaves_2_read_address_channel_ARVALID),
    .io_slaves_2_read_address_channel_ARREADY(bus_switch_io_slaves_2_read_address_channel_ARREADY),
    .io_slaves_2_read_address_channel_ARADDR(bus_switch_io_slaves_2_read_address_channel_ARADDR),
    .io_slaves_2_read_data_channel_RVALID(bus_switch_io_slaves_2_read_data_channel_RVALID),
    .io_slaves_2_read_data_channel_RREADY(bus_switch_io_slaves_2_read_data_channel_RREADY),
    .io_slaves_2_read_data_channel_RDATA(bus_switch_io_slaves_2_read_data_channel_RDATA),
    .io_slaves_3_write_address_channel_AWREADY(bus_switch_io_slaves_3_write_address_channel_AWREADY),
    .io_slaves_3_write_data_channel_WREADY(bus_switch_io_slaves_3_write_data_channel_WREADY),
    .io_slaves_3_write_response_channel_BVALID(bus_switch_io_slaves_3_write_response_channel_BVALID),
    .io_slaves_3_read_address_channel_ARREADY(bus_switch_io_slaves_3_read_address_channel_ARREADY),
    .io_slaves_3_read_data_channel_RVALID(bus_switch_io_slaves_3_read_data_channel_RVALID),
    .io_slaves_4_write_address_channel_AWREADY(bus_switch_io_slaves_4_write_address_channel_AWREADY),
    .io_slaves_4_write_data_channel_WREADY(bus_switch_io_slaves_4_write_data_channel_WREADY),
    .io_slaves_4_write_response_channel_BVALID(bus_switch_io_slaves_4_write_response_channel_BVALID),
    .io_slaves_4_read_address_channel_ARREADY(bus_switch_io_slaves_4_read_address_channel_ARREADY),
    .io_slaves_4_read_data_channel_RVALID(bus_switch_io_slaves_4_read_data_channel_RVALID),
    .io_slaves_5_write_address_channel_AWREADY(bus_switch_io_slaves_5_write_address_channel_AWREADY),
    .io_slaves_5_write_data_channel_WREADY(bus_switch_io_slaves_5_write_data_channel_WREADY),
    .io_slaves_5_write_response_channel_BVALID(bus_switch_io_slaves_5_write_response_channel_BVALID),
    .io_slaves_5_read_address_channel_ARREADY(bus_switch_io_slaves_5_read_address_channel_ARREADY),
    .io_slaves_5_read_data_channel_RVALID(bus_switch_io_slaves_5_read_data_channel_RVALID),
    .io_slaves_6_write_address_channel_AWREADY(bus_switch_io_slaves_6_write_address_channel_AWREADY),
    .io_slaves_6_write_data_channel_WREADY(bus_switch_io_slaves_6_write_data_channel_WREADY),
    .io_slaves_6_write_response_channel_BVALID(bus_switch_io_slaves_6_write_response_channel_BVALID),
    .io_slaves_6_read_address_channel_ARREADY(bus_switch_io_slaves_6_read_address_channel_ARREADY),
    .io_slaves_6_read_data_channel_RVALID(bus_switch_io_slaves_6_read_data_channel_RVALID),
    .io_slaves_7_write_address_channel_AWVALID(bus_switch_io_slaves_7_write_address_channel_AWVALID),
    .io_slaves_7_write_address_channel_AWREADY(bus_switch_io_slaves_7_write_address_channel_AWREADY),
    .io_slaves_7_write_data_channel_WVALID(bus_switch_io_slaves_7_write_data_channel_WVALID),
    .io_slaves_7_write_data_channel_WREADY(bus_switch_io_slaves_7_write_data_channel_WREADY),
    .io_slaves_7_write_response_channel_BVALID(bus_switch_io_slaves_7_write_response_channel_BVALID),
    .io_slaves_7_write_response_channel_BREADY(bus_switch_io_slaves_7_write_response_channel_BREADY),
    .io_slaves_7_read_address_channel_ARVALID(bus_switch_io_slaves_7_read_address_channel_ARVALID),
    .io_slaves_7_read_address_channel_ARREADY(bus_switch_io_slaves_7_read_address_channel_ARREADY),
    .io_slaves_7_read_data_channel_RVALID(bus_switch_io_slaves_7_read_data_channel_RVALID),
    .io_slaves_7_read_data_channel_RREADY(bus_switch_io_slaves_7_read_data_channel_RREADY),
    .io_master_write_address_channel_AWVALID(bus_switch_io_master_write_address_channel_AWVALID),
    .io_master_write_address_channel_AWREADY(bus_switch_io_master_write_address_channel_AWREADY),
    .io_master_write_address_channel_AWADDR(bus_switch_io_master_write_address_channel_AWADDR),
    .io_master_write_data_channel_WVALID(bus_switch_io_master_write_data_channel_WVALID),
    .io_master_write_data_channel_WREADY(bus_switch_io_master_write_data_channel_WREADY),
    .io_master_write_data_channel_WDATA(bus_switch_io_master_write_data_channel_WDATA),
    .io_master_write_data_channel_WSTRB(bus_switch_io_master_write_data_channel_WSTRB),
    .io_master_write_response_channel_BVALID(bus_switch_io_master_write_response_channel_BVALID),
    .io_master_write_response_channel_BREADY(bus_switch_io_master_write_response_channel_BREADY),
    .io_master_read_address_channel_ARVALID(bus_switch_io_master_read_address_channel_ARVALID),
    .io_master_read_address_channel_ARREADY(bus_switch_io_master_read_address_channel_ARREADY),
    .io_master_read_address_channel_ARADDR(bus_switch_io_master_read_address_channel_ARADDR),
    .io_master_read_data_channel_RVALID(bus_switch_io_master_read_data_channel_RVALID),
    .io_master_read_data_channel_RREADY(bus_switch_io_master_read_data_channel_RREADY),
    .io_master_read_data_channel_RDATA(bus_switch_io_master_read_data_channel_RDATA)
  );
  assign io_instruction_address = cpu_io_instruction_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 66:28]
  assign io_mem_slave_address = mem_slave_io_bundle_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 52:16]
  assign io_mem_slave_read = mem_slave_io_bundle_read; // @[4-soc/src/main/scala/board/verilator/Top.scala 52:16]
  assign io_mem_slave_write = mem_slave_io_bundle_write; // @[4-soc/src/main/scala/board/verilator/Top.scala 52:16]
  assign io_mem_slave_write_data = mem_slave_io_bundle_write_data; // @[4-soc/src/main/scala/board/verilator/Top.scala 52:16]
  assign io_mem_slave_write_strobe_0 = mem_slave_io_bundle_write_strobe_0; // @[4-soc/src/main/scala/board/verilator/Top.scala 52:16]
  assign io_mem_slave_write_strobe_1 = mem_slave_io_bundle_write_strobe_1; // @[4-soc/src/main/scala/board/verilator/Top.scala 52:16]
  assign io_mem_slave_write_strobe_2 = mem_slave_io_bundle_write_strobe_2; // @[4-soc/src/main/scala/board/verilator/Top.scala 52:16]
  assign io_mem_slave_write_strobe_3 = mem_slave_io_bundle_write_strobe_3; // @[4-soc/src/main/scala/board/verilator/Top.scala 52:16]
  assign io_vga_hsync = vga_io_hsync; // @[4-soc/src/main/scala/board/verilator/Top.scala 96:22]
  assign io_vga_vsync = vga_io_vsync; // @[4-soc/src/main/scala/board/verilator/Top.scala 97:22]
  assign io_vga_rrggbb = vga_io_rrggbb; // @[4-soc/src/main/scala/board/verilator/Top.scala 98:22]
  assign io_vga_activevideo = vga_io_activevideo; // @[4-soc/src/main/scala/board/verilator/Top.scala 99:22]
  assign io_vga_x_pos = vga_io_x_pos; // @[4-soc/src/main/scala/board/verilator/Top.scala 100:22]
  assign io_vga_y_pos = vga_io_y_pos; // @[4-soc/src/main/scala/board/verilator/Top.scala 101:22]
  assign io_uart_txd = uart_io_txd; // @[4-soc/src/main/scala/board/verilator/Top.scala 104:21]
  assign io_uart_interrupt = uart_io_signal_interrupt; // @[4-soc/src/main/scala/board/verilator/Top.scala 106:21]
  assign io_cpu_debug_read_data = cpu_io_debug_read_data; // @[4-soc/src/main/scala/board/verilator/Top.scala 113:33]
  assign io_cpu_csr_debug_read_data = cpu_io_csr_debug_read_data; // @[4-soc/src/main/scala/board/verilator/Top.scala 115:33]
  assign mem_slave_clock = clock;
  assign mem_slave_reset = reset;
  assign mem_slave_io_channels_write_address_channel_AWVALID = bus_switch_io_slaves_0_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign mem_slave_io_channels_write_address_channel_AWADDR = bus_switch_io_slaves_0_write_address_channel_AWADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign mem_slave_io_channels_write_data_channel_WVALID = bus_switch_io_slaves_0_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign mem_slave_io_channels_write_data_channel_WDATA = bus_switch_io_slaves_0_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign mem_slave_io_channels_write_data_channel_WSTRB = bus_switch_io_slaves_0_write_data_channel_WSTRB; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign mem_slave_io_channels_write_response_channel_BREADY = bus_switch_io_slaves_0_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign mem_slave_io_channels_read_address_channel_ARVALID = bus_switch_io_slaves_0_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign mem_slave_io_channels_read_address_channel_ARADDR = bus_switch_io_slaves_0_read_address_channel_ARADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign mem_slave_io_channels_read_data_channel_RREADY = bus_switch_io_slaves_0_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign mem_slave_io_bundle_read_data = io_mem_slave_read_data; // @[4-soc/src/main/scala/board/verilator/Top.scala 52:16]
  assign mem_slave_io_bundle_read_valid = io_mem_slave_read_valid; // @[4-soc/src/main/scala/board/verilator/Top.scala 52:16]
  assign vga_clock = clock;
  assign vga_reset = reset;
  assign vga_io_channels_write_address_channel_AWVALID = bus_switch_io_slaves_1_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign vga_io_channels_write_address_channel_AWADDR = bus_switch_io_slaves_1_write_address_channel_AWADDR[7:0]; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign vga_io_channels_write_data_channel_WVALID = bus_switch_io_slaves_1_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign vga_io_channels_write_data_channel_WDATA = bus_switch_io_slaves_1_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign vga_io_channels_write_response_channel_BREADY = bus_switch_io_slaves_1_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign vga_io_channels_read_address_channel_ARVALID = bus_switch_io_slaves_1_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign vga_io_channels_read_address_channel_ARADDR = bus_switch_io_slaves_1_read_address_channel_ARADDR[7:0]; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign vga_io_channels_read_data_channel_RREADY = bus_switch_io_slaves_1_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign vga_io_pixClock = io_vga_pixclk; // @[4-soc/src/main/scala/board/verilator/Top.scala 95:22]
  assign uart_clock = clock;
  assign uart_reset = reset;
  assign uart_io_channels_write_address_channel_AWVALID = bus_switch_io_slaves_2_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign uart_io_channels_write_address_channel_AWADDR = bus_switch_io_slaves_2_write_address_channel_AWADDR[7:0]; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign uart_io_channels_write_data_channel_WVALID = bus_switch_io_slaves_2_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign uart_io_channels_write_data_channel_WDATA = bus_switch_io_slaves_2_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign uart_io_channels_write_response_channel_BREADY = bus_switch_io_slaves_2_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign uart_io_channels_read_address_channel_ARVALID = bus_switch_io_slaves_2_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign uart_io_channels_read_address_channel_ARADDR = bus_switch_io_slaves_2_read_address_channel_ARADDR[7:0]; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign uart_io_channels_read_data_channel_RREADY = bus_switch_io_slaves_2_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign uart_io_rxd = io_uart_rxd; // @[4-soc/src/main/scala/board/verilator/Top.scala 105:21]
  assign cpu_clock = clock;
  assign cpu_reset = reset;
  assign cpu_io_instruction = io_instruction; // @[4-soc/src/main/scala/board/verilator/Top.scala 67:28]
  assign cpu_io_instruction_valid = io_instruction_valid; // @[4-soc/src/main/scala/board/verilator/Top.scala 68:28]
  assign cpu_io_axi4_channels_write_address_channel_AWREADY = bus_switch_io_master_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign cpu_io_axi4_channels_write_data_channel_WREADY = bus_switch_io_master_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign cpu_io_axi4_channels_write_response_channel_BVALID = bus_switch_io_master_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign cpu_io_axi4_channels_read_address_channel_ARREADY = bus_switch_io_master_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign cpu_io_axi4_channels_read_data_channel_RVALID = bus_switch_io_master_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign cpu_io_axi4_channels_read_data_channel_RDATA = bus_switch_io_master_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign cpu_io_interrupt_flag = {{31'd0}, io_signal_interrupt}; // @[4-soc/src/main/scala/board/verilator/Top.scala 109:25]
  assign cpu_io_debug_read_address = io_cpu_debug_read_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 112:33]
  assign cpu_io_csr_debug_read_address = io_cpu_csr_debug_read_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 114:33]
  assign dummy_clock = clock;
  assign dummy_reset = reset;
  assign dummy_io_channels_write_address_channel_AWVALID = bus_switch_io_slaves_7_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign dummy_io_channels_write_data_channel_WVALID = bus_switch_io_slaves_7_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign dummy_io_channels_write_response_channel_BREADY = bus_switch_io_slaves_7_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign dummy_io_channels_read_address_channel_ARVALID = bus_switch_io_slaves_7_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign dummy_io_channels_read_data_channel_RREADY = bus_switch_io_slaves_7_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_clock = clock;
  assign bus_switch_reset = reset;
  assign bus_switch_io_address = cpu_io_bus_address; // @[4-soc/src/main/scala/board/verilator/Top.scala 86:25]
  assign bus_switch_io_slaves_0_write_address_channel_AWREADY = mem_slave_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign bus_switch_io_slaves_0_write_data_channel_WREADY = mem_slave_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign bus_switch_io_slaves_0_write_response_channel_BVALID = mem_slave_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign bus_switch_io_slaves_0_read_address_channel_ARREADY = mem_slave_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign bus_switch_io_slaves_0_read_data_channel_RVALID = mem_slave_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign bus_switch_io_slaves_0_read_data_channel_RDATA = mem_slave_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 87:27]
  assign bus_switch_io_slaves_1_write_address_channel_AWREADY = vga_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign bus_switch_io_slaves_1_write_data_channel_WREADY = vga_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign bus_switch_io_slaves_1_write_response_channel_BVALID = vga_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign bus_switch_io_slaves_1_read_address_channel_ARREADY = vga_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign bus_switch_io_slaves_1_read_data_channel_RVALID = vga_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign bus_switch_io_slaves_1_read_data_channel_RDATA = vga_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 88:27]
  assign bus_switch_io_slaves_2_write_address_channel_AWREADY = uart_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign bus_switch_io_slaves_2_write_data_channel_WREADY = uart_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign bus_switch_io_slaves_2_write_response_channel_BVALID = uart_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign bus_switch_io_slaves_2_read_address_channel_ARREADY = uart_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign bus_switch_io_slaves_2_read_data_channel_RVALID = uart_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign bus_switch_io_slaves_2_read_data_channel_RDATA = uart_io_channels_read_data_channel_RDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 89:27]
  assign bus_switch_io_slaves_3_write_address_channel_AWREADY = dummy_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_3_write_data_channel_WREADY = dummy_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_3_write_response_channel_BVALID = dummy_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_3_read_address_channel_ARREADY = dummy_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_3_read_data_channel_RVALID = dummy_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_4_write_address_channel_AWREADY = dummy_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_4_write_data_channel_WREADY = dummy_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_4_write_response_channel_BVALID = dummy_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_4_read_address_channel_ARREADY = dummy_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_4_read_data_channel_RVALID = dummy_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_5_write_address_channel_AWREADY = dummy_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_5_write_data_channel_WREADY = dummy_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_5_write_response_channel_BVALID = dummy_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_5_read_address_channel_ARREADY = dummy_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_5_read_data_channel_RVALID = dummy_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_6_write_address_channel_AWREADY = dummy_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_6_write_data_channel_WREADY = dummy_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_6_write_response_channel_BVALID = dummy_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_6_read_address_channel_ARREADY = dummy_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_6_read_data_channel_RVALID = dummy_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_7_write_address_channel_AWREADY = dummy_io_channels_write_address_channel_AWREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_7_write_data_channel_WREADY = dummy_io_channels_write_data_channel_WREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_7_write_response_channel_BVALID = dummy_io_channels_write_response_channel_BVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_7_read_address_channel_ARREADY = dummy_io_channels_read_address_channel_ARREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_slaves_7_read_data_channel_RVALID = dummy_io_channels_read_data_channel_RVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 91:29]
  assign bus_switch_io_master_write_address_channel_AWVALID = cpu_io_axi4_channels_write_address_channel_AWVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign bus_switch_io_master_write_address_channel_AWADDR = cpu_io_axi4_channels_write_address_channel_AWADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign bus_switch_io_master_write_data_channel_WVALID = cpu_io_axi4_channels_write_data_channel_WVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign bus_switch_io_master_write_data_channel_WDATA = cpu_io_axi4_channels_write_data_channel_WDATA; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign bus_switch_io_master_write_data_channel_WSTRB = cpu_io_axi4_channels_write_data_channel_WSTRB; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign bus_switch_io_master_write_response_channel_BREADY = cpu_io_axi4_channels_write_response_channel_BREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign bus_switch_io_master_read_address_channel_ARVALID = cpu_io_axi4_channels_read_address_channel_ARVALID; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign bus_switch_io_master_read_address_channel_ARADDR = cpu_io_axi4_channels_read_address_channel_ARADDR; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
  assign bus_switch_io_master_read_data_channel_RREADY = cpu_io_axi4_channels_read_data_channel_RREADY; // @[4-soc/src/main/scala/board/verilator/Top.scala 85:24]
endmodule
