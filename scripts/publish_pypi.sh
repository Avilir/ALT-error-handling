#!/bin/bash
# Script to publish ALT-error-handling to PyPI or TestPyPI

set -e  # Exit on error

# Check if environment argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [test|prod]"
    echo "  test - Publish to TestPyPI"
    echo "  prod - Publish to PyPI"
    exit 1
fi

ENV=$1

# Ensure we're in virtual environment
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Error: Virtual environment not activated!"
    echo "Please run: source venv/bin/activate"
    exit 1
fi

# Check if twine is installed
if ! command -v twine &> /dev/null; then
    echo "Error: twine not found. Installing..."
    pip install twine
fi

# Check if dist directory exists
if [ ! -d "dist" ]; then
    echo "Error: dist/ directory not found. Run 'make build' first."
    exit 1
fi

# Publish based on environment
if [ "$ENV" = "test" ]; then
    echo "Publishing to TestPyPI..."
    echo "Make sure you have configured ~/.pypirc with testpypi credentials"
    twine upload --repository testpypi dist/*
    echo ""
    echo "Package uploaded to TestPyPI!"
    echo "Install with: pip install --index-url https://test.pypi.org/simple/ ALT-error-handling"
elif [ "$ENV" = "prod" ]; then
    echo "Publishing to PyPI..."
    echo "Make sure you have configured ~/.pypirc with pypi credentials"
    read -p "Are you sure you want to publish to production PyPI? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        twine upload dist/*
        echo ""
        echo "Package uploaded to PyPI!"
        echo "Install with: pip install ALT-error-handling"
    else
        echo "Publishing cancelled."
        exit 0
    fi
else
    echo "Error: Invalid environment '$ENV'. Use 'test' or 'prod'."
    exit 1
fi
