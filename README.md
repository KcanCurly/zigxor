# How to use

Add following to build.zig.zon (Hash will change, in order to get the correct hash remove the hash section and build the project, you should get the correct hash)

```zig
.dependencies = .{
    .ZigXor = .{ .url = "https://github.com/KcanCurly/zigxor/archive/refs/tags/v0.0.1-alpha.zip", .hash = "zigxor-A.B.C-HASH" },
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

# Credits
[Maldev Academy](https://maldevacademy.com/)