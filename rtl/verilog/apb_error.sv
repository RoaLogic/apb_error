/////////////////////////////////////////////////////////////////////
//   ,------.                    ,--.                ,--.          //
//   |  .--. ' ,---.  ,--,--.    |  |    ,---. ,---. `--' ,---.    //
//   |  '--'.'| .-. |' ,-.  |    |  |   | .-. | .-. |,--.| .--'    //
//   |  |\  \ ' '-' '\ '-'  |    |  '--.' '-' ' '-' ||  |\ `--.    //
//   `--' '--' `---'  `--`--'    `-----' `---' `-   /`--' `---'    //
//                                             `---'               //
//   APB Error Module                                              //
//                                                                 //
/////////////////////////////////////////////////////////////////////
//                                                                 //
//             Copyright (C) 2021 ROA Logic BV                     //
//             www.roalogic.com                                    //
//                                                                 //
//   This source file may be used and distributed without          //
//   restriction provided that this copyright statement is not     //
//   removed from the file and that any derivative work contains   //
//   the original copyright notice and the associated disclaimer.  //
//                                                                 //
//      THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY        //
//   EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED     //
//   TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS     //
//   FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR OR     //
//   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,  //
//   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT  //
//   NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;  //
//   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)      //
//   HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN     //
//   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR  //
//   OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS          //
//   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  //
//                                                                 //
/////////////////////////////////////////////////////////////////////

// +FHDR -  Semiconductor Reuse Standard File Header Section  -------
// FILE NAME      : apb_error.sv
// DEPARTMENT     :
// AUTHOR         : rherveille
// AUTHOR'S EMAIL :
// ------------------------------------------------------------------
// RELEASE HISTORY
// VERSION DATE        AUTHOR      DESCRIPTION
// 1.0     2021-11-27  rherveille  initial release
// ------------------------------------------------------------------
// KEYWORDS : AMBA APB Error
// ------------------------------------------------------------------
// PURPOSE  : Generate an APB error transaction
// ------------------------------------------------------------------
// PARAMETERS
//  PARAM NAME        RANGE    DESCRIPTION              DEFAULT UNITS
//  PDATA_SIZE        1+       Data bus size            8       bits
// ------------------------------------------------------------------
// REUSE ISSUES 
//   Reset Strategy      : external asynchronous active low; PRESETn
//   Clock Domains       : PCLK, rising edge
//   Critical Timing     : 
//   Test Features       : na
//   Asynchronous I/F    : no
//   Scan Methodology    : na
//   Instantiations      : na
//   Synthesizable (y/n) : Yes
//   Other               :                                         
// -FHDR-------------------------------------------------------------


module apb_error #(
  parameter PDATA_SIZE = 8
)
(
  input  logic                  PRESETn,
         logic                  PCLK,

  input  logic                  PSEL,
  input  logic                  PENABLE,
  output logic [PDATA_SIZE-1:0] PRDATA,
  output logic                  PREADY,
  output logic                  PSLVERR
);


  //////////////////////////////////////////////////////////////////
  //
  // Module Body
  //

  assign PRDATA = {PDATA_SIZE{1'b0}};

  
  //raise error when addressed
  always @(posedge PCLK, negedge PRESETn)
    if (!PRESETn)
    begin
        PREADY  <= 1'b0;
	PSLVERR <= 1'b0;
    end
    else if (PSEL)
    begin
        PREADY  <= ~PREADY;
        PSLVERR <= ~PSLVERR;
    end

endmodule
