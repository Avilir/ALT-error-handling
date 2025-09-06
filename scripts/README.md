# Scripts Directory

This directory contains helper scripts for the ALT-error-handling project.

## Files

### publish_pypi.sh

Script to publish the package to PyPI or TestPyPI.

**Usage:**
```bash
# Publish to TestPyPI
./scripts/publish_pypi.sh test

# Publish to production PyPI
./scripts/publish_pypi.sh prod
```

**Prerequisites:**
1. Virtual environment must be activated
2. Package must be built (`make build`)
3. PyPI credentials must be configured (see below)

### .pypirc.template

Template for PyPI configuration. To use:

1. Copy to your home directory:
   ```bash
   cp scripts/.pypirc.template ~/.pypirc
   ```

2. Update with your tokens:
   - Get PyPI token from: https://pypi.org/manage/account/token/
   - Get TestPyPI token from: https://test.pypi.org/manage/account/token/

3. Set appropriate permissions:
   ```bash
   chmod 600 ~/.pypirc
   ```

## Publishing Workflow

1. Update version in `pyproject.toml`
2. Run tests: `make test`
3. Build package: `make build`
4. Test on TestPyPI: `make publish-test`
5. If successful, publish to PyPI: `make publish-prod`
