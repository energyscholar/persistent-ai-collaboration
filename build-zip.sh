#!/bin/bash
cd "$(dirname "$0")"
zip -j persistent-ai-collaboration.zip index.html tutorial-magnetosphere.html LICENSE
zip -r persistent-ai-collaboration-full.zip index.html tutorial-magnetosphere.html tutorial-inference.html tutorials/ LICENSE
echo "Core: $(du -h persistent-ai-collaboration.zip | cut -f1) | Full: $(du -h persistent-ai-collaboration-full.zip | cut -f1)"
