const std = @import("std");
const x = @import("lib.zig");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 4) {
        std.debug.print("Usage: {s} <input_file> <key> <output_file>\n", .{args[0]});
        return;
    }

    const input_path = args[1];
    const key = args[2];
    const output_path = args[3];

    // Read file into memory
    const input_data = try std.fs.cwd().readFileAlloc(allocator, input_path, 20 * 1024 * 1024); // 20MB max

    // Encrypt/decrypt
    x.xor(input_data, key);

    // Write output
    const output_file = try std.fs.cwd().createFile(output_path, .{ .truncate = true });
    defer output_file.close();
    try output_file.writeAll(input_data);

    std.debug.print("[+] Wrote XOR'd output to '{s}'\n", .{output_path});
}
