//TEST BENCH FOR DOOR LOCK

module door_lock_tb;
    reg in;
    reg clk; 
    reg reset;
    wire unlock; 
    wire error;
    door_lock DUT(.unlock(unlock), .error(error),  .reset(reset), .in(in) , .clk(clk));

    initial begin
        $dumpfile("door_lock.vcd");
        $dumpvars(0, door_lock_tb);
        $monitor("T=%t ,RESET=%b, UNLOCK=%b, ERROR=%b", $time, reset, unlock, error);
    end

    initial begin
        clk=0;
    end

    always begin
        #5 clk= ~clk;
    end

    initial begin
        reset=1;
        #5 reset=0;
        //CORRECT 
        #10 in=1;
        #10 in=0;
        #10 in=1;
        #10 in=0;
        //INCORRECT
        #10 in=10;
        #10 in=0;
        #10 in=1;
        #10 in=0;
        #100 $finish;
    end
endmodule