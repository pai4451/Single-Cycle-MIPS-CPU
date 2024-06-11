# In the InstMem.v, why do we index the Mem via address[31:2] instead of address[31:0]? Please give me an example.

In the provided MIPS 32-bit CPU Instruction Memory (InstMem) module, we use `address[31:2]` to index the `Mem` array instead of `address[31:0]`. This is because MIPS instructions are word-aligned, meaning each instruction is 32 bits (4 bytes) long and stored at addresses that are multiples of 4. Let's break down the reasoning and give an example.

### Reason for Using `address[31:2]`

1. **Word-Alignment**: In a MIPS CPU, instructions are word-aligned. This means that each instruction starts at an address that is a multiple of 4 (0, 4, 8, 12, ...). Using `address[31:2]` ensures that we only access word-aligned addresses by ignoring the lower 2 bits of the address.
   
2. **Memory Array Indexing**: The `Mem` array in the module is declared as `reg [31:0] Mem [0:127]`, which means it has 128 words, and each word is 32 bits wide. If we used the entire `address[31:0]` to index the `Mem` array, it would imply that we can access individual bytes, which is not the case here because `Mem` is word-addressable.

### Example

Let's consider an example to illustrate this:

#### Example 1: Fetching an Instruction at Address 0

- `address = 32'h0000_0000` (hexadecimal representation for 0)
- `address[31:2] = 32'h0000_0000` (since the lower 2 bits are ignored, the result is still 0)

So, `Mem[address[31:2]]` translates to `Mem[0]`, which is the first instruction in the memory.

#### Example 2: Fetching an Instruction at Address 4

- `address = 32'h0000_0004` (hexadecimal representation for 4)
- `address[31:2] = 32'h0000_0001` (shifting right by 2 bits, 4 becomes 1)

So, `Mem[address[31:2]]` translates to `Mem[1]`, which is the second instruction in the memory.

#### Example 3: Fetching an Instruction at Address 8

- `address = 32'h0000_0008` (hexadecimal representation for 8)
- `address[31:2] = 32'h0000_0002` (shifting right by 2 bits, 8 becomes 2)

So, `Mem[address[31:2]]` translates to `Mem[2]`, which is the third instruction in the memory.

### Address Bit Shifting Explanation

When we use `address[31:2]`, we are effectively dividing the address by 4 (since shifting right by 2 bits is equivalent to dividing by 4). This converts the byte address into a word address, which is necessary for correctly indexing the word-aligned instruction memory.

By using `address[31:2]`, we ensure that the instruction memory is accessed in units of words (32 bits) rather than bytes. This matches the typical organization of MIPS instruction memory and simplifies the hardware design for fetching instructions.

### Summary

Using `address[31:2]` ensures that we correctly fetch word-aligned instructions from the instruction memory. It converts the byte address to a word address by ignoring the lower 2 bits, which correspond to the byte offset within a word, thus ensuring correct indexing in the word-addressable memory array.