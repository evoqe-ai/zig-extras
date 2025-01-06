const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule(
        "extras",
        .{
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("src/lib.zig"),
        },
    );

    const exe_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = optimize,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    run_exe_unit_tests.has_side_effects = true;

    const test_step = b.step("test", "dummy test step to pass CI checks");
    test_step.dependOn(&run_exe_unit_tests.step);
}
