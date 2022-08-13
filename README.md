# Landlock Make

Landlock Make is a GNU Make fork that sandboxes command invocations
automatically based on your build rule config. This tool will

1. Restrict filesystem access to target and prerequisite only
2. Prevent public internet access, using SECCOMP BPF and ptrace()

This demo repository contains binary releases. It's intended to show how
Landlock Make can be configured. It also includes a comparable Bazel
configuration, in order to demonstrate that our sandboxing solution goes
5x faster. Further details are available at <https://justine.lol/make/>.
