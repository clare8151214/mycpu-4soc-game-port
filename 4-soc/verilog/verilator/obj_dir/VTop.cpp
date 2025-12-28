// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VTop__pch.h"

//============================================================
// Constructors

VTop::VTop(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VTop__Syms(contextp(), _vcname__, this)}
    , clock{vlSymsp->TOP.clock}
    , io_vga_pixclk{vlSymsp->TOP.io_vga_pixclk}
    , reset{vlSymsp->TOP.reset}
    , io_signal_interrupt{vlSymsp->TOP.io_signal_interrupt}
    , io_instruction_valid{vlSymsp->TOP.io_instruction_valid}
    , io_mem_slave_read{vlSymsp->TOP.io_mem_slave_read}
    , io_mem_slave_read_valid{vlSymsp->TOP.io_mem_slave_read_valid}
    , io_mem_slave_write{vlSymsp->TOP.io_mem_slave_write}
    , io_mem_slave_write_strobe_0{vlSymsp->TOP.io_mem_slave_write_strobe_0}
    , io_mem_slave_write_strobe_1{vlSymsp->TOP.io_mem_slave_write_strobe_1}
    , io_mem_slave_write_strobe_2{vlSymsp->TOP.io_mem_slave_write_strobe_2}
    , io_mem_slave_write_strobe_3{vlSymsp->TOP.io_mem_slave_write_strobe_3}
    , io_vga_hsync{vlSymsp->TOP.io_vga_hsync}
    , io_vga_vsync{vlSymsp->TOP.io_vga_vsync}
    , io_vga_rrggbb{vlSymsp->TOP.io_vga_rrggbb}
    , io_vga_activevideo{vlSymsp->TOP.io_vga_activevideo}
    , io_uart_txd{vlSymsp->TOP.io_uart_txd}
    , io_uart_rxd{vlSymsp->TOP.io_uart_rxd}
    , io_uart_interrupt{vlSymsp->TOP.io_uart_interrupt}
    , io_cpu_debug_read_address{vlSymsp->TOP.io_cpu_debug_read_address}
    , io_vga_x_pos{vlSymsp->TOP.io_vga_x_pos}
    , io_vga_y_pos{vlSymsp->TOP.io_vga_y_pos}
    , io_cpu_csr_debug_read_address{vlSymsp->TOP.io_cpu_csr_debug_read_address}
    , io_instruction_address{vlSymsp->TOP.io_instruction_address}
    , io_instruction{vlSymsp->TOP.io_instruction}
    , io_mem_slave_address{vlSymsp->TOP.io_mem_slave_address}
    , io_mem_slave_read_data{vlSymsp->TOP.io_mem_slave_read_data}
    , io_mem_slave_write_data{vlSymsp->TOP.io_mem_slave_write_data}
    , io_cpu_debug_read_data{vlSymsp->TOP.io_cpu_debug_read_data}
    , io_cpu_csr_debug_read_data{vlSymsp->TOP.io_cpu_csr_debug_read_data}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VTop::VTop(const char* _vcname__)
    : VTop(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VTop::~VTop() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void VTop___024root___eval_debug_assertions(VTop___024root* vlSelf);
#endif  // VL_DEBUG
void VTop___024root___eval_static(VTop___024root* vlSelf);
void VTop___024root___eval_initial(VTop___024root* vlSelf);
void VTop___024root___eval_settle(VTop___024root* vlSelf);
void VTop___024root___eval(VTop___024root* vlSelf);

void VTop::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VTop::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VTop___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        VTop___024root___eval_static(&(vlSymsp->TOP));
        VTop___024root___eval_initial(&(vlSymsp->TOP));
        VTop___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    VTop___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool VTop::eventsPending() { return false; }

uint64_t VTop::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* VTop::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void VTop___024root___eval_final(VTop___024root* vlSelf);

VL_ATTR_COLD void VTop::final() {
    VTop___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VTop::hierName() const { return vlSymsp->name(); }
const char* VTop::modelName() const { return "VTop"; }
unsigned VTop::threads() const { return 1; }
void VTop::prepareClone() const { contextp()->prepareClone(); }
void VTop::atClone() const {
    contextp()->threadPoolpOnClone();
}

//============================================================
// Trace configuration

VL_ATTR_COLD void VTop::trace(VerilatedVcdC* tfp, int levels, int options) {
    vl_fatal(__FILE__, __LINE__, __FILE__,"'VTop::trace()' called on model that was Verilated without --trace option");
}
