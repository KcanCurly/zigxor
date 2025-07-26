const std = @import("std");

/// XORs input with a key. Same function can encrypt or decrypt.
pub fn xor(input: []u8, key: []const u8) void {
    var i: usize = 0;
    while (i < input.len) : (i += 1) {
        input[i] ^= key[i % key.len];
    }
}

pub fn xorInMemory(input: *anyopaque, input_size: usize, key: []const u8, output: *anyopaque) !void {
    const allocator = std.heap.page_allocator;
    const decrypted = try allocator.alloc(u8, input_size);
    std.mem.copyForwards(u8, decrypted, input);
    xor(decrypted, key);
    const p: [*]u8 = @ptrCast(output);
    const slice = p[0..decrypted.len];

    @memcpy(slice, decrypted);
    allocator.free();
}
