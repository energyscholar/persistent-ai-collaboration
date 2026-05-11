#!/bin/bash
cd "$(dirname "$0")"
zip -j persistent-ai-collaboration.zip index.html tutorial-magnetosphere.html LICENSE
echo "Built: persistent-ai-collaboration.zip ($(du -h persistent-ai-collaboration.zip | cut -f1))"
