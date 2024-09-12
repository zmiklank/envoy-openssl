workspace(name = "envoy")

local_repository(
    name = "bssl-compat",
    path = "bssl-compat",
)

load("//bazel:api_binding.bzl", "envoy_api_binding")

envoy_api_binding()

load("//bazel:api_repositories.bzl", "envoy_api_dependencies")

envoy_api_dependencies()

load("//bazel:repositories.bzl", "envoy_dependencies")

envoy_dependencies()

load("//bazel:repositories_extra.bzl", "envoy_dependencies_extra")

envoy_dependencies_extra()

load("//bazel:python_dependencies.bzl", "envoy_python_dependencies")

envoy_python_dependencies()

load("//bazel:dependency_imports.bzl", "envoy_dependency_imports")

envoy_dependency_imports()

new_local_repository(
    name = "openssl",
    path = "/usr",
    build_file = "BUILD.openssl",
)
new_local_repository(
    name = "clang",
    path = "/opt/llvm/",
    build_file_content ="""
load("@rules_cc//cc:defs.bzl", "cc_library")

licenses(["notice"])  # Apache 2

cc_library(
    name = "clang_lib",
    hdrs = glob([
      "include/**/*",
    ]),
    srcs = [
      "lib/libclang-cpp.so",
      "lib/libclang-cpp.so.14",
      "lib/libclang.so.13",
      "lib/libclangAST.a",
      "lib/libclangFrontend.a",
      "lib/libclangTooling.a",
      "lib/libclangBasic.a",
      "lib/libclangLex.a",
    ],
    includes = ["include"],
    linkopts = ["-Llib", "-lclang"],
    visibility = ["//visibility:public"],
)
    """,
)
