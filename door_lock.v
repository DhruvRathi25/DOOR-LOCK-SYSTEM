//DOOR LOCK WITH PASSWORD

module door_lock(unlock, error,  reset, in, clk);
    output reg unlock;
    output reg error;
    input in;
    input clk,
    input reset;
    reg[2:0] state;
    reg[3:0] entered_pass= 4'b0000;
    reg[2:0] count;

    parameter IDLE=3'b000, INPUT=3'b001, CHECK=3'b010, UNLOCK=3'b011, ERROR=3'b100;

    parameter PASSWORD= 4'b1010;
    
    always@(posedge clk or posedge reset) begin
        if(reset) begin
            state<= IDLE;
            entered_pass<= 4'b0000;
            unlock<=0;
            error<=0;
            count<=3'b000;
        end
        else begin
        case(state)
        IDLE : begin
            state<= INPUT;
            entered_pass<= 4'b0000;
            unlock<=0;
            error<=0;
            count<=3'b00;
        end
        INPUT: begin
            if(count==3'b100) state<=CHECK;
            else begin
                entered_pass<= {entered_pass[2:0], in};
                count<= count +1;
            end   
        end
        CHECK: begin
            if(entered_pass == PASSWORD) begin
                state<=UNLOCK;
            end
            else begin
                state<=ERROR;
            end
        end
        UNLOCK: begin
            unlock<=1;
            state<= IDLE;
        end
        ERROR: begin
            error<=1;
            state<= IDLE;
        end
        endcase
        end
    end
endmodule

