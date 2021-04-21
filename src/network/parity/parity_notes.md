# Parity
* bit added to a binary string
* typically applied at a byte level
* is the # of 1-bits **even or odd**
* Odd will set it to 1, making the total bits even
* So there should always be an even number of bits

Calculation
* Sum the bits, take the mod 2
* add the parity bit and send
Receive
* computes parity, error if 1

```vhdl
entity parity_unit is
    port (
        data:   in std_logic_vector(7 downto 0);
        parity: out std_logic;
    );
end parity;
```
And its architecture
```vhdl
-- Not sure if our version of vhdl will support this
architecture parity1 of parity_unit is
begin
    parity <= xor data;
end parity1;

-- This should be more stable
architecture parity2 of parity_unit is
    signal temp: std_logic_vector(7 downto 1);
begin
    temp(0) <= data(0);
    gen: for i in 1 to 7:
        temp(i) <= temp(i-1) xor data(i);
    end generate;
    parity <= temp(7);
end parity2;
```

The configuration we're using right now
```vhdl
--- The architecture we're using in our test bench
architecture structure of COMPLETE is
    component parity_unit port(...);
begin
    PARITY: parity_unit port map(...);
end structure;

-- Wire it up
architecture structure of COMPLETE is
    component parity_unit port(...);
    -- With this to choose the configuration
    for ALL: parity_unit use entity work.parity_unit(parity1);
begin
    PARITY: parity_unit port map(...);
end structure;
```