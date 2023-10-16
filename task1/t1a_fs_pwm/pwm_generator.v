// AstroTinker Bot : Task 1A : PWM Generator
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 3.125MHz Clock Frequency to 195.125KHz and perform Pulse Width Modulation on it.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//PWM Generator
//Inputs : clk_3125KHz, duty_cycle
//Output : clk_195KHz, pwm_signal


module pwm_generator(
    input clk_3125KHz,
    input [3:0] duty_cycle,
    output reg clk_195KHz, pwm_signal
);

initial begin
    clk_195KHz = 0; pwm_signal = 1;
end

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////
reg[2:0] clk_scale_counter=0;
reg[3:0] pwm_counter=0;

always @(posedge clk_3125KHz)
begin
	if(!clk_scale_counter)
	begin
		clk_195KHz = ~clk_195KHz;
	end
	if(pwm_counter < duty_cycle)
	begin
		pwm_signal = 1'b1;
	end
	else
	begin
		pwm_signal = 1'b0;
	end
	pwm_counter = pwm_counter + 1'b1;
	clk_scale_counter = clk_scale_counter + 1'b1;
end
//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////
endmodule
