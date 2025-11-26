# Claude Code Configuration

Personal Claude Code configuration, skills, and preferences.

## Files

- **CLAUDE.md** - Global instructions for Claude Code behavior across all projects
- **config.json** - Project-level configuration
- **settings.json** - Claude Code settings (plugins, thinking mode)
- **skills/go-engineering/** - Custom Go engineering skill
- **skills/python-engineering/** - Custom Python engineering skill

## What's Configured

### CLAUDE.md
- Concise, pragmatic engineering approach
- Git confirmation workflow
- YAGNI-focused design principles
- Systematic debugging framework
- Testing requirements

### settings.json
- Enables `alwaysThinkingEnabled`
- Enables `example-skills@anthropic-agent-skills` plugin
- Disables `includeCoAuthoredBy`

### Go Engineering Skill
Comprehensive Go guidelines covering:
- Project structure & naming
- Error handling & concurrency
- Testing with testify/require
- Performance patterns
- gopls, gofmt, golangci-lint integration

Invoke with: "use the go-engineering skill"

### Python Engineering Skill
Comprehensive Python guidelines covering:
- Project structure with src/ layout
- Naming conventions (PEP 8)
- Error handling & async/await patterns
- Type hints & Pydantic
- Testing with pytest
- CLI development with Typer
- AI agents with LangGraph
- uv, ruff, mypy integration

Invoke with: "use the python-engineering skill"
