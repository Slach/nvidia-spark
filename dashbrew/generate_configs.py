#!/usr/bin/env python3
import urllib.request
import json
import sys

# Specify your llama.cpp server address
LLAMACPP_API_BASE = "http://127.0.0.1:8090"

def get_models():
    """Fetches the list of all loaded models via the OpenAI-compatible API"""
    url = f"{LLAMACPP_API_BASE}/v1/models"
    try:
        req = urllib.request.Request(url)
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode())
            # Return a list of model IDs
            return [m["id"] for m in data.get("data",[])]
    except Exception as e:
        print(f"❌ Connection error to {url}: {e}")
        return[]

def generate_dashbrew_config(model_id):
    """Generates a Dashbrew JSON configuration for a specific model"""
    
    # Replace slashes and colons with underscores for a safe filename
    safe_name = model_id.replace("/", "_").replace(":", "_")
    filename = f"dashbrew_{safe_name}.json"
    
    config = {
        "style": {
            "border": {
                "type": "thicc",
                "color": "#4caf50",          # Green borders
                "focusedColor": "#ff9800"    # Orange on focus
            }
        },
        "layout": {
            "type": "container",
            "direction": "column", # Arrange charts vertically (one below the other)
            "children":[
                {
                    "type": "component",
                    "flex": 2, # Takes 40% of the screen height
                    "component": {
                        "type": "chart",
                        "title": f" 🚀 Generation Speed (Tokens/sec) - {model_id} ",
                        "data": {
                            "source": "script",
                            # Extract only the generation speed value
                            "command": f"curl -s '{LLAMACPP_API_BASE}/metrics?model={model_id}' | grep '^llamacpp:predicted_tokens_seconds' | awk '{{print $2}}'",
                            "refresh_interval": 1,
                            "caption": "Tokens / Sec"
                        }
                    }
                },
                {
                    "type": "component",
                    "flex": 2, # Another 40% of the screen height
                    "component": {
                        "type": "chart",
                        "title": " 📥 Prompt Processing Speed (Tokens/sec) ",
                        "data": {
                            "source": "script",
                            # Extract the prefill speed
                            "command": f"curl -s '{LLAMACPP_API_BASE}/metrics?model={model_id}' | grep '^llamacpp:prompt_tokens_seconds' | awk '{{print $2}}'",
                            "refresh_interval": 1,
                            "caption": "Tokens / Sec"
                        }
                    }
                },
                {
                    "type": "component",
                    "flex": 1, # The remaining 20% of the screen height
                    "component": {
                        "type": "text",
                        "title": " ⚙️ Current Load & Queue ",
                        "data": {
                            "source": "script",
                            # This awk script elegantly combines active requests and the queue into a single text string
                            "command": f"curl -s '{LLAMACPP_API_BASE}/metrics?model={model_id}' | awk '/^llamacpp:requests_processing/ {{ req=$2 }} /^llamacpp:requests_deferred/ {{ def=$2 }} END {{ print \"Active requests (Processing): \" req \" \\nQueued requests (Deferred): \" def }}'",
                            "refresh_interval": 1
                        }
                    }
                }
            ]
        }
    }
    
    # Save to file
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(config, f, indent=4, ensure_ascii=False)
        
    print(f"✅ Config created: {filename}")
    print(f"▶️  To run, type: dashbrew -c {filename}\n")

if __name__ == "__main__":
    print(f"⏳ Polling llama.cpp server at {LLAMACPP_API_BASE}...\n")
    models = get_models()
    
    if not models:
        print("⚠️ No models found. Make sure the llama.cpp server is running and accessible.")
        sys.exit(1)
        
    print(f"Models found: {len(models)}")
    for m in models:
        generate_dashbrew_config(m)