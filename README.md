# AI Chatbot Plugin for PHPNuxBill

## Overview
The AI Chatbot plugin adds a modern conversational launcher to PHPNuxBill. It handles the
complete flow from collecting visitor messages, proxying them to your AI endpoint, and
rendering responses inside a floating widget that can be injected into any PHPNuxBill
footer template. All configuration is exposed through an admin panel so you can toggle the
feature, control the end-user experience, and adjust authentication without touching code.

## Key Features
- **Floating launcher widget** with customizable title, label, avatar, side positioning, and
  responsive frame size defined in [`ui/ai_chatbot.tpl`](ui/ai_chatbot.tpl).
- **Sectioned admin settings page** (`General`, `Chat Experience`, `Conversation History`,
  and `Authentication`) built with [`ui/ai_chatbot_settings.tpl`](ui/ai_chatbot_settings.tpl).
- **Automatic footer injection** that wraps the chatbot include between
  `<!-- AI_CHATBOT_PLUGIN_START -->` and `<!-- AI_CHATBOT_PLUGIN_END -->` markers so the widget
  can be injected or removed safely from multiple templates.
- **Configurable AI proxy** that sanitizes requests, supports Basic auth, custom headers, and
  JWT bearer tokens before forwarding traffic to the upstream AI endpoint.
- **Conversation controls** for welcome prompts, typing indicators, input limits, and
  history capping by TTL or number of messages.
- **Session-aware proxy endpoints** (`bootstrap` and `proxy`) that cache configuration in
  `$CACHE_PATH/ai_chatbot` for resilience across requests.

## Requirements
- PHPNuxBill with the plugin system enabled and ORM helpers available (the plugin writes to
  `tbl_appconfig`).
- PHP 7.4 or newer with the `curl`, `json`, and `session` extensions enabled.
- Writable cache directory defined by `$CACHE_PATH` so the plugin can store proxy
  configuration state.

## Installation
1. Copy or clone this repository into your PHPNuxBill `plugins` directory as
   `ai_chatbot` (e.g. `phpnuxbill/plugins/ai_chatbot`).
2. Ensure the file permissions allow PHP to read plugin files and write to the cache
   directory.
3. Log in to the PHPNuxBill admin panel. The plugin automatically registers the menu entry
   **Settings → AI Chatbot** via `register_menu()` in [`ai_chatbot.php`](ai_chatbot.php).
4. Open **Settings → AI Chatbot** and configure the plugin before enabling it for users.

## Configuration Guide
The admin screen is divided into logical tabs so you can onboard the chatbot step-by-step.

### General
- **Enable Chatbot** – Turn the widget on/off globally.
- **AI Endpoint URL** – REST endpoint that receives proxied requests.
- **Request Timeout** – Limits proxy waiting time (5–600 seconds).
- **Footer Injection Targets** – Multi-select templates where the chatbot snippet is
  automatically inserted. Templates missing from disk are flagged, and the plugin falls
  back to common defaults if nothing is discovered.

### Chat Experience
- Customize the launcher title, button label, avatar, and side positioning (left/right).
- Control the iframe mode (`fixed` or `auto`) plus width and height limits.
- Optional welcome message and typing simulation (`off` or words-per-minute mode).
- Cap end-user input length (100–4,000 characters) to protect your backend.

### Conversation History
- Choose how history is retained: **TTL** (in minutes) or **Count** (max messages).
- Configure history TTL and message count caps, both sanitized by the plugin.

### Authentication
- Select **None**, **Basic**, **Header**, or **JWT**.
- Provide Basic credentials, header key/value pairs, or JWT claims (`iss`, `aud`, `sub`,
  TTL) along with secrets/tokens. The plugin automatically normalizes values and can send
  header values as bearer tokens when requested.

Whenever you save settings the plugin sanitizes the payload, persists it via ORM, updates
`$config`, and re-syncs all targeted footer templates. If a footer already contains a
chatbot marker it is refreshed instead of duplicated.

## Runtime Flow
1. The front-end requests the **bootstrap** route to obtain a proxy ID, configuration key,
   optional CSRF token, and the proxy endpoint URL.
2. Each message is POSTed to the **proxy** route with the proxy ID/config key. The plugin
   validates CSRF tokens (when enabled), enforces character limits, normalizes history, and
   sends a JSON payload plus helpful headers (`X-Chat-Meta`, `X-Chat-Visitor`, etc.) to your
   AI service.
3. Responses (or retry-safe errors) are returned to the front-end, and proxy state is kept
   alive for the duration of `AI_CHATBOT_PROXY_TTL` (default 30 minutes).

If a session expires the plugin will transparently refresh the proxy context using the
cached config. Fatal errors trigger user-friendly retry messages.

## Development Notes
- Update [`ui/ai_chatbot.tpl`](ui/ai_chatbot.tpl) to adjust widget styling. The template
  reads settings from the global `$_c` config array populated by `ai_chatbot_load_config()`.
- Modify [`ui/ai_chatbot_settings.tpl`](ui/ai_chatbot_settings.tpl) to extend the admin UI.
- Snippet markers are defined by `AI_CHATBOT_SNIPPET_START` and
  `AI_CHATBOT_SNIPPET_END`. If you customize footer templates manually, keep these markers
  intact so the auto-synchronization job can continue to manage injections safely.

## Troubleshooting
- **Chatbot not showing** – Confirm the plugin is enabled, the selected footer templates
  exist, and the widget include markers appear near `</body>`.
- **Proxy errors** – Check that the AI endpoint is reachable and credentials are correct.
  Inspect the PHP error log for detailed `curl` error codes reported by
  `ai_chatbot_forward_request()`.
- **Session expired** – The UI will prompt users to reload when the proxy TTL lapses. Make
  sure `$CACHE_PATH` is writable so cached configs can repopulate expired sessions.

For further customization, explore the helper functions inside
[`ai_chatbot.php`](ai_chatbot.php) which centralize normalization, caching, and proxy logic.
