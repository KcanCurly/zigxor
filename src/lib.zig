const std = @import("std");
const testing = std.testing;

/// XORs input with a key. Same function can encrypt or decrypt.
pub fn xor(input: []u8, key: []const u8) void {
    var i: usize = 0;
    while (i < input.len) : (i += 1) {
        input[i] ^= key[i % key.len];
    }
}

pub fn xorInMemory(input: [*]u8, input_size: usize, key: []const u8, output: [*]u8) !void {
    const input_ptr: [*]const u8 = @ptrCast(input);
    const input_slice = input_ptr[0..input_size];

    const output_ptr: [*]u8 = @ptrCast(output);
    const output_slice = output_ptr[0..input_size];

    std.mem.copyForwards(u8, output_slice, input_slice);

    xor(output_slice, key);
}

test "basic" {
    const allocator = std.heap.page_allocator;

    const input = "test";
    const input_ptr: [*]u8 = @ptrCast(@constCast(input.ptr));

    const output = try allocator.alloc(u8, input.len);
    const output_ptr: [*]u8 = @ptrCast(@constCast(output.ptr));

    const key = "WXYZ";

    try xorInMemory(input_ptr, input.len, key, output_ptr);

    try testing.expect(output_ptr[0] == 35);
}
