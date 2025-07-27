# How to use

## Exe

```zig
zigxor.exe <input_file> <key> <output_file>
```

## Library

Add following to build.zig.zon (Hash will change, in order to get the correct hash remove the hash section and build the project, you should get the correct hash)

```zig
.dependencies = .{
    .ZigXor = .{ .url = "https://github.com/KcanCurly/zigxor/archive/refs/tags/vX.X.X.zip", .hash = "zigxor-A.B.C-HASH" },
    }
```

Add following to build.zig

```zig
const zigxor_dep = b.dependency("ZigXor", .{ .target = target, .optimize = optimize }); \
const zigxor_mod = zigxor_dep.module("ZigXor"); \
exe_mod.addImport("zigxor", zigxor_mod); 
```

Add following to main.zig

```zig
const x = @import("zigxor");
```

### Example

```zig
const x = @import("zigxor");

const allocator = std.heap.page_allocator;

const input = "test";
const input_ptr: [*]u8 = @ptrCast(@constCast(input.ptr));

const output = try allocator.alloc(u8, input.len);
const output_ptr: [*]u8 = @ptrCast(@constCast(output.ptr));

const key = "WXYZ";

try xorInMemory(input_ptr, input.len, key, output_ptr);
```

# Credits
[Maldev Academy](https://maldevacademy.com/)