// AstroTinker Bot : Task 1C : Pulse Generator and Detector
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to design a module which will generate a 10us pulse and detect incoming pulse signal.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

// t1c_pulse_gen_detect
//Inputs : clk_50M, reset, echo_rx
//Output : trigger, distance, pulses, state

// module declaration
module t1c_pulse_gen_detect (
    input clk_50M, reset, echo_rx,
    output reg trigger, out,
    output reg [21:0] pulses,
    output reg [1:0] state
);

initial begin
    trigger = 0; out = 0; pulses = 0; state = 0;
end


//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

// Defining State Machine Parameters
parameter ST_WARMUP=2'b00, ST_TRIG=2'b01, ST_READ=2'b10;
    
reg [1:0] state_ = ST_WARMUP;
reg [5:0] counter_delay = 0;
reg [8:0] counter_trig = 0;
reg [15:0] counter_loop  = 0;

always @ (posedge clk_50M) 
begin

if (reset == 1) begin

    trigger = 0; 
	 out = 0; 
	 pulses = 1; 
	 state = 0;
	 state_ = ST_WARMUP;
    counter_delay = 0;
    counter_trig = 0;
    counter_loop  = 0;
	 
end	

else begin
    case (state_)
	      ST_WARMUP: 
			begin
				
				if (counter_delay < 50 ) 
				begin
					counter_delay <= counter_delay + 1;
					trigger <= 0;    
				end 
				else 
				begin
					counter_delay <= 0;
					
					trigger <= 1;			 
					state_ = ST_TRIG; 
				end
				state = ST_WARMUP;
			end
			ST_TRIG: 
			begin
					if (counter_trig < 499 ) 
					begin
						counter_trig <= counter_trig + 1;
						trigger <= 1;
					end 
					else 
					begin
						counter_trig <= 0;
						trigger <= 0;
						state_ <= ST_READ;
					end
					state = ST_TRIG;
			end
			ST_READ: 
			begin
				
					if(echo_rx)
					begin 
						pulses = pulses + 1;
					end
					if (counter_loop == 49999) 
					begin
						if (pulses == 29410) out = 1;
					   else 
					   begin
					   if (reset!=1 & out == 1) out = 1;
					   else out = 0;
					   end
					   pulses <= 1;
						counter_loop <=0;
					   state_ <= ST_WARMUP;
						
					end
					else counter_loop <= counter_loop + 1;
				

			end
			default: begin
				state_ = ST_WARMUP;
				state = ST_WARMUP;
			end
endcase
end
end
//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////
endmodule