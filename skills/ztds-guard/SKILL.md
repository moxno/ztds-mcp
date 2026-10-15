---
name: ztds-guard
description: Enforces Zero-Trust Data Sanitization (ZTDS RFC v1.0) across AI coding agents (Claude Code, Cursor, Codex, Gemini CLI, Windsurf). Masks raw PII, API secrets, and regulated identifiers in local RAM with reversible surrogate tokens before prompts, file reads, or tool calls leave the machine.
license: Apache-2.0
metadata:
  author: moxno
  version: "1.0.2"
  mcp_server: "npx -y ztds-mcp"
---

# ZTDS Guard — Zero-Trust Data Sanitization Skill

Use this skill whenever an AI agent handles untrusted or sensitive files, environment variables, customer logs, financial records, or healthcare identifiers before sending context to external LLM APIs.

## Quick Setup (MCP Server)

```bash
claude mcp add ztds -- npx -y ztds-mcp
```

Or in `.mcp.json` / `.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "ztds": {
      "command": "npx",
      "args": ["-y", "ztds-mcp"]
    }
  }
}
```

## Operating Protocol

1. **Pre-Call Sanitization (`ztds_sanitize`):** Before passing raw user text, logs, or file contents containing PII or credentials into external model reasoning, call `ztds_sanitize` to replace sensitive entities with syntax-preserving surrogate tokens (`[EMAIL_TOKEN_1]`, `[API_SECRET_TOKEN_1]`, `[SSN_TOKEN_1]`).
2. **Local Restoration (`ztds_restore`):** When unmasked values are required locally for user display or downstream execution, call `ztds_restore` to re-hydrate tokens from volatile RAM.
3. **Compliance Verification (`ztds_audit`):** Run `ztds_audit` on staged files or prompts to generate a deterministic SHA-256 compliance receipt and risk score with zero network egress.
4. **Session Zeroization (`ztds_reset_session`):** Call `ztds_reset_session` at task completion to zeroize volatile in-memory token mappings (ZTDS RFC v1.0 Theorem 2).
