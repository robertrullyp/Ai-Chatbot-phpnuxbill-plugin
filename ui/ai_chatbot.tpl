{* Smarty *}
{assign var=chatbot value=$_c}
{assign var=chatbot_title value=$chatbot.chatbot_title|default:'AI Chat'}
{assign var=button_label value=$chatbot.chatbot_button_label|trim}
{if $button_label == ''}
    {assign var=button_label value=$chatbot_title}
{/if}
{assign var=button_label value=$button_label|default:'AI Chat'}
{assign var=button_side value=$chatbot.chatbot_button_side|default:'right'}
{assign var=frame_width value=$chatbot.chatbot_frame_width|default:340|intval}
{assign var=frame_height value=$chatbot.chatbot_frame_height|default:460|intval}
{assign var=frame_mode value=$chatbot.chatbot_frame_mode|default:'fixed'}
{assign var=chatbot_enabled value=$chatbot.chatbot_enabled|default:'0'}
{assign var=handoff_enabled value=$chatbot.chatbot_handoff_enabled|default:'0'}
{assign var=handoff_label value=$chatbot.chatbot_handoff_label|trim}
{if $handoff_label == ''}{assign var=handoff_label value='Chat dengan Admin'}{/if}
{assign var=bot_bg value=$chatbot.chatbot_bubble_bot_bg|trim}
{if $bot_bg == ''}{assign var=bot_bg value='var(--chatbot-surface)'}{/if}
{assign var=bot_text value=$chatbot.chatbot_bubble_bot_text|trim}
{if $bot_text == ''}{assign var=bot_text value='var(--chatbot-text)'}{/if}
{assign var=bot_border value=$chatbot.chatbot_bubble_bot_border|trim}
{if $bot_border == ''}{assign var=bot_border value='var(--chatbot-bubble-border)'}{/if}
{assign var=user_bg value=$chatbot.chatbot_bubble_user_bg|trim}
{if $user_bg == ''}{assign var=user_bg value='linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-primary-strong))'}{/if}
{assign var=user_text value=$chatbot.chatbot_bubble_user_text|trim}
{if $user_text == ''}{assign var=user_text value='#ffffff'}{/if}
{assign var=user_border value=$chatbot.chatbot_bubble_user_border|trim}
{if $user_border == ''}{assign var=user_border value='transparent'}{/if}
{assign var=message_font value=$chatbot.chatbot_message_font_family|trim}
{if $message_font == ''}{assign var=message_font value='inherit'}{/if}
{assign var=header_bg value=$chatbot.chatbot_header_bg|trim}
{if $header_bg == ''}{assign var=header_bg value='var(--chatbot-header-bg-default)'}{/if}
{assign var=header_text value=$chatbot.chatbot_header_text|trim}
{if $header_text == ''}{assign var=header_text value='var(--chatbot-header-text-default)'}{/if}
{assign var=launcher_bg value=$chatbot.chatbot_launcher_bg|trim}
{if $launcher_bg == ''}{assign var=launcher_bg value='var(--chatbot-launcher-bg-default)'}{/if}
{assign var=launcher_text value=$chatbot.chatbot_launcher_text|trim}
{if $launcher_text == ''}{assign var=launcher_text value='var(--chatbot-launcher-text-default)'}{/if}
{assign var=send_bg value=$chatbot.chatbot_send_bg|trim}
{if $send_bg == ''}{assign var=send_bg value='var(--chatbot-send-bg-default)'}{/if}
{assign var=send_text value=$chatbot.chatbot_send_text|trim}
{if $send_text == ''}{assign var=send_text value='var(--chatbot-send-text-default)'}{/if}
{assign var=frame_bg value=$chatbot.chatbot_frame_bg|trim}
{if $frame_bg == ''}{assign var=frame_bg value='var(--chatbot-frame-bg-default)'}{/if}
{assign var=messages_bg value=$chatbot.chatbot_messages_bg|trim}
{if $messages_bg == ''}{assign var=messages_bg value='var(--chatbot-messages-bg-default)'}{/if}
{assign var=input_bg value=$chatbot.chatbot_input_bg|trim}
{if $input_bg == ''}{assign var=input_bg value='var(--chatbot-input-bg-default)'}{/if}
{assign var=input_text value=$chatbot.chatbot_input_text|trim}
{if $input_text == ''}{assign var=input_text value='var(--chatbot-input-text-default)'}{/if}
{assign var=input_border value=$chatbot.chatbot_input_border|trim}
{if $input_border == ''}{assign var=input_border value='var(--chatbot-input-border-default)'}{/if}
{assign var=input_area_bg value=$chatbot.chatbot_input_area_bg|trim}
{if $input_area_bg == ''}{assign var=input_area_bg value='var(--chatbot-input-area-bg-default)'}{/if}

<style>
    .ai-chatbot-root {
        --chatbot-primary: #0d9488;
        --chatbot-primary-strong: #0f766e;
        --chatbot-accent: #06b6d4;
        --chatbot-bg: #f1f6f8;
        --chatbot-surface: #ffffff;
        --chatbot-text: #0f172a;
        --chatbot-muted: #6b7280;
        --chatbot-radius: 18px;
        --chatbot-header-bg-default: linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-accent));
        --chatbot-header-text-default: #ffffff;
        --chatbot-launcher-bg-default: linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-primary-strong));
        --chatbot-launcher-text-default: #ffffff;
        --chatbot-send-bg-default: linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-accent));
        --chatbot-send-text-default: #ffffff;
        --chatbot-frame-bg-default: #ffffff;
        --chatbot-messages-bg-default: var(--chatbot-bg);
        --chatbot-input-bg-default: #f8fafc;
        --chatbot-input-text-default: var(--chatbot-text);
        --chatbot-input-border-default: rgba(148, 163, 184, 0.45);
        --chatbot-input-area-bg-default: rgba(255, 255, 255, 0.95);
        --chatbot-bubble-border: rgba(226, 232, 240, 0.8);
        --chatbot-bubble-radius: {$chatbot.chatbot_bubble_radius|default:14|intval}px;
        --chatbot-bubble-padding-x: {$chatbot.chatbot_bubble_padding_x|default:14|intval}px;
        --chatbot-bubble-padding-y: {$chatbot.chatbot_bubble_padding_y|default:10|intval}px;
        --chatbot-bubble-font-size: {$chatbot.chatbot_bubble_font_size|default:14|intval}px;
        --chatbot-bubble-line-height: {$chatbot.chatbot_bubble_line_height|default:'1.45'|escape};
        --chatbot-bubble-max-width: {$chatbot.chatbot_bubble_max_width|default:80|intval}%;
        --chatbot-bubble-bot-bg: {$bot_bg|escape};
        --chatbot-bubble-bot-text: {$bot_text|escape};
        --chatbot-bubble-bot-border: {$bot_border|escape};
        --chatbot-bubble-user-bg: {$user_bg|escape};
        --chatbot-bubble-user-text: {$user_text|escape};
        --chatbot-bubble-user-border: {$user_border|escape};
        --chatbot-message-font: {$message_font|escape};
        --chatbot-header-bg: {$header_bg|escape};
        --chatbot-header-text: {$header_text|escape};
        --chatbot-launcher-bg: {$launcher_bg|escape};
        --chatbot-launcher-text: {$launcher_text|escape};
        --chatbot-send-bg: {$send_bg|escape};
        --chatbot-send-text: {$send_text|escape};
        --chatbot-frame-bg: {$frame_bg|escape};
        --chatbot-messages-bg: {$messages_bg|escape};
        --chatbot-input-bg: {$input_bg|escape};
        --chatbot-input-text: {$input_text|escape};
        --chatbot-input-border: {$input_border|escape};
        --chatbot-input-area-bg: {$input_area_bg|escape};
        --chatbot-input-area-padding-x: {$chatbot.chatbot_input_area_padding_x|default:14|intval}px;
        --chatbot-input-area-padding-y: {$chatbot.chatbot_input_area_padding_y|default:12|intval}px;
        --chatbot-input-area-blur: {$chatbot.chatbot_input_area_blur|default:8|intval}px;
        --chatbot-input-bg-focus: var(--chatbot-input-bg);
        --chatbot-shadow: 0 18px 40px rgba(15, 23, 42, 0.18);
        --chatbot-ring: 0 0 0 3px rgba(13, 148, 136, 0.2);
        --chatbot-side-spacing: 24px;
        --chatbot-z-index: 1050;
        position: fixed;
        bottom: var(--chatbot-side-spacing);
        display: flex;
        flex-direction: column-reverse;
        align-items: flex-end;
        gap: 12px;
        z-index: var(--chatbot-z-index);
    }

    .ai-chatbot-root[data-enabled="0"] {
        display: none;
    }

    .ai-chatbot-root--right {
        right: var(--chatbot-side-spacing);
        flex-direction: column-reverse;
        align-items: flex-end;
    }

    .ai-chatbot-root--left {
        left: var(--chatbot-side-spacing);
        flex-direction: column-reverse;
        align-items: flex-start;
    }

    .ai-chatbot-button {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        background: var(--chatbot-launcher-bg);
        color: var(--chatbot-launcher-text);
        border: none;
        border-radius: 999px;
        padding: 0 22px;
        height: 46px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        box-shadow: 0 14px 26px rgba(13, 148, 136, 0.35);
        transition: transform 0.25s ease, box-shadow 0.25s ease, filter 0.25s ease;
        position: relative;
        overflow: hidden;
    }

    .ai-chatbot-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 18px 36px rgba(14, 116, 144, 0.4);
        filter: saturate(1.1);
    }

    .ai-chatbot-button:focus-visible {
        outline: none;
        box-shadow: var(--chatbot-ring);
    }

    .ai-chatbot-button::after {
        content: "";
        position: absolute;
        top: -40%;
        left: -10%;
        width: 60%;
        height: 180%;
        background: radial-gradient(circle at center, rgba(255, 255, 255, 0.4), rgba(255, 255, 255, 0));
        opacity: 0.75;
        transform: translateX(-40%) rotate(-12deg);
        transition: transform 0.35s ease;
        pointer-events: none;
    }

    .ai-chatbot-button:hover::after {
        transform: translateX(40%) rotate(-12deg);
    }

    .ai-chatbot-button-icon {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .ai-chatbot-button-text {
        white-space: nowrap;
    }

    .ai-chatbot-frame {
        display: none;
        flex-direction: column;
        width: min(94vw, max({$frame_width}px, 420px));
        height: min(78vh, max({$frame_height}px, 520px));
        min-height: 460px;
        background: var(--chatbot-frame-bg);
        border-radius: var(--chatbot-radius);
        box-shadow: var(--chatbot-shadow);
        border: 1px solid rgba(148, 163, 184, 0.35);
        overflow: hidden;
        position: relative;
        transform-origin: bottom center;
    }

    .ai-chatbot-frame[data-frame-mode="auto"] {
        height: auto;
        max-height: 80vh;
        min-height: 460px;
    }

    .ai-chatbot-frame.is-open {
        display: flex;
        animation: chatbot-frame-in 220ms ease-out both;
    }

    .ai-chatbot-frame::before {
        content: "";
        position: absolute;
        inset: 0;
        background:
            radial-gradient(circle at 18% 15%, rgba(13, 148, 136, 0.08), transparent 46%),
            radial-gradient(circle at 92% 18%, rgba(6, 182, 212, 0.08), transparent 46%);
        opacity: 0.9;
        pointer-events: none;
    }

    .chatbot-header {
        background: var(--chatbot-header-bg);
        color: var(--chatbot-header-text);
        --chatbot-avatar-size: 34px;
        padding: 12px 16px 10px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        position: relative;
        z-index: 1;
    }

    .chatbot-header__info {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: 2px;
        min-width: 0;
    }

    .chatbot-header__title {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        font-weight: 700;
        font-size: 16px;
        line-height: 1.2;
    }

    .chatbot-header__text {
        display: flex;
        flex-direction: column;
        justify-content: center;
        gap: 2px;
        min-width: 0;
    }

    .chatbot-header__name {
        display: block;
        font-weight: 700;
        font-size: 16px;
        line-height: 1.2;
    }

    .chatbot-header__avatar {
        width: var(--chatbot-avatar-size);
        height: var(--chatbot-avatar-size);
        aspect-ratio: 1 / 1;
        border-radius: 50%;
        object-fit: cover;
        object-position: center;
        display: block;
        flex-shrink: 0;
        cursor: zoom-in;
        background: rgba(255, 255, 255, 0.85);
        border: 2px solid rgba(255, 255, 255, 0.8);
    }

    .chatbot-header__avatar--placeholder {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
        font-weight: 700;
        color: var(--chatbot-primary-strong);
        background: rgba(255, 255, 255, 0.9);
        border: 2px solid rgba(255, 255, 255, 0.85);
        cursor: default;
    }

    .chatbot-header__status {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-weight: 600;
        font-size: 12px;
        line-height: 1.2;
        color: var(--chatbot-header-text);
    }

    .chatbot-header__status.is-handoff {
        font-weight: 700;
    }

    .chatbot-header__status::before {
        content: "";
        width: 7px;
        height: 7px;
        border-radius: 999px;
        background: #22c55e;
        box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.25);
    }

    .chatbot-header__status[data-status="checking"]::before {
        background: #f59e0b;
        box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.25);
        animation: chatbot-status-pulse 1.4s ease-in-out infinite;
    }

    .chatbot-header__status[data-status="offline"]::before {
        background: #ef4444;
        box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.25);
    }

    .chatbot-header__actions {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        flex-shrink: 0;
    }

    .chatbot-handoff {
        background: rgba(255, 255, 255, 0.18);
        border: 1px solid rgba(255, 255, 255, 0.35);
        color: var(--chatbot-header-text);
        padding: 6px 12px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 600;
        cursor: pointer;
        line-height: 1;
        transition: background 0.25s ease, transform 0.25s ease, opacity 0.25s ease;
    }

    .chatbot-handoff:hover {
        background: rgba(255, 255, 255, 0.32);
        transform: translateY(-1px);
    }

    .chatbot-handoff:disabled {
        cursor: not-allowed;
        opacity: 0.6;
        transform: none;
    }

    @keyframes chatbot-status-pulse {
        0% {
            transform: scale(1);
            opacity: 1;
        }
        50% {
            transform: scale(1.3);
            opacity: 0.7;
        }
        100% {
            transform: scale(1);
            opacity: 1;
        }
    }

    .chatbot-close {
        background: rgba(255, 255, 255, 0.18);
        border: none;
        color: var(--chatbot-header-text);
        width: 34px;
        height: 34px;
        min-width: 34px;
        min-height: 34px;
        aspect-ratio: 1 / 1;
        padding: 0;
        border-radius: 50%;
        font-size: 20px;
        line-height: 1;
        cursor: pointer;
        display: inline-flex;
        justify-content: center;
        align-items: center;
        transition: background-color 0.25s ease, transform 0.25s ease;
    }

    .chatbot-close:hover {
        background: rgba(255, 255, 255, 0.35);
        transform: scale(1.05);
    }

    .chatbot-close:focus-visible {
        outline: 2px solid rgba(255, 255, 255, 0.6);
        outline-offset: 2px;
    }

    .chatbot-messages {
        flex: 1;
        padding: 16px 16px 12px;
        overflow-y: auto;
        background: var(--chatbot-messages-bg);
        display: flex;
        flex-direction: column;
        gap: 12px;
        scroll-behavior: smooth;
        position: relative;
        z-index: 1;
        min-height: 240px;
    }

    .chatbot-messages::-webkit-scrollbar {
        width: 8px;
    }

    .chatbot-messages::-webkit-scrollbar-thumb {
        background: rgba(100, 116, 139, 0.35);
        border-radius: 999px;
    }

    .chatbot-scroll-bottom {
        position: absolute;
        right: 12px;
        bottom: 68px;
        height: 30px;
        min-height: 30px;
        max-height: 30px;
        width: 128px;
        min-width: 96px;
        border-radius: 999px;
        border: none;
        background: rgba(15, 23, 42, 0.08);
        color: var(--chatbot-text);
        box-shadow: 0 6px 12px rgba(15, 23, 42, 0.12);
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        padding: 0 12px;
        line-height: 1;
        opacity: 0;
        pointer-events: none;
        transform: translateY(4px);
        transition: opacity 0.2s ease, transform 0.2s ease, background-color 0.2s ease;
        z-index: 2;
        backdrop-filter: blur(6px);
        -webkit-backdrop-filter: blur(6px);
        top: auto;
    }

    .chatbot-scroll-bottom svg {
        width: 12px;
        height: 12px;
        flex-shrink: 0;
    }

    .chatbot-scroll-bottom__label {
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 0.02em;
    }

    .chatbot-scroll-bottom.is-visible {
        opacity: 1;
        pointer-events: auto;
        transform: translateY(0);
    }

    .chatbot-scroll-bottom:hover {
        background: rgba(15, 23, 42, 0.16);
    }

    body.dark-mode .chatbot-scroll-bottom,
    .dark-mode .chatbot-scroll-bottom,
    [data-theme="dark"] .chatbot-scroll-bottom {
        background: rgba(148, 163, 184, 0.16);
        color: #e2e8f0;
    }

    body.dark-mode .chatbot-scroll-bottom:hover,
    .dark-mode .chatbot-scroll-bottom:hover,
    [data-theme="dark"] .chatbot-scroll-bottom:hover {
        background: rgba(148, 163, 184, 0.28);
    }

    .chatbot-message {
        display: flex;
        max-width: var(--chatbot-bubble-max-width, 80%);
        animation: chatbot-message-in 180ms ease-out both;
        position: relative;
    }

    .chatbot-message.user {
        margin-left: auto;
        flex-direction: row-reverse;
    }

    .chatbot-message.bot {
        padding-left: 22px;
    }

    .chatbot-message-content {
        padding: var(--chatbot-bubble-padding-y) var(--chatbot-bubble-padding-x);
        border-radius: var(--chatbot-bubble-radius);
        box-shadow: 0 8px 16px rgba(15, 23, 42, 0.08);
        background: var(--chatbot-bubble-bot-bg);
        color: var(--chatbot-bubble-bot-text);
        font-size: var(--chatbot-bubble-font-size);
        line-height: var(--chatbot-bubble-line-height);
        font-family: var(--chatbot-message-font, inherit);
        word-break: break-word;
        border: 1px solid var(--chatbot-bubble-bot-border);
        position: relative;
    }

    .chatbot-copy-btn {
        position: absolute;
        left: 0;
        bottom: 4px;
        width: 16px !important;
        height: 16px !important;
        border-radius: 4px;
        border: none;
        background: rgba(15, 23, 42, 0.12);
        color: var(--chatbot-bubble-bot-text);
        display: inline-flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        pointer-events: none;
        transition: opacity 0.2s ease, transform 0.2s ease, background-color 0.2s ease;
        cursor: pointer;
        padding: 0 !important;
        min-height: 0 !important;
        line-height: 1 !important;
        transform: translateY(4px);
    }

    .chatbot-message:hover .chatbot-copy-btn,
    .chatbot-message:focus-within .chatbot-copy-btn {
        opacity: 1;
        pointer-events: auto;
        transform: translateY(0);
    }

    .chatbot-copy-btn:hover {
        background: rgba(15, 23, 42, 0.16);
    }

    .chatbot-copy-btn svg {
        width: 10px;
        height: 10px;
    }

    .chatbot-message.user .chatbot-copy-btn {
        background: rgba(255, 255, 255, 0.25);
        color: #ffffff;
    }

    .chatbot-message.user .chatbot-copy-btn:hover {
        background: rgba(255, 255, 255, 0.4);
    }

    body.dark-mode .chatbot-copy-btn,
    .dark-mode .chatbot-copy-btn,
    [data-theme="dark"] .chatbot-copy-btn {
        background: rgba(148, 163, 184, 0.2);
        color: #e2e8f0;
    }

    body.dark-mode .chatbot-copy-btn:hover,
    .dark-mode .chatbot-copy-btn:hover,
    [data-theme="dark"] .chatbot-copy-btn:hover {
        background: rgba(148, 163, 184, 0.32);
    }

    .chatbot-message-content p {
        margin: 0 0 0.45em;
    }

    .chatbot-message-content p:last-child {
        margin-bottom: 0;
    }

    .chatbot-message-content ul,
    .chatbot-message-content ol {
        margin: 0.4em 0 0.4em 1.1em;
        padding: 0;
    }

    .chatbot-message-content li {
        margin: 0.2em 0;
    }

    .chatbot-message-content blockquote {
        margin: 0.5em 0;
        padding-left: 0.75em;
        border-left: 2px solid rgba(148, 163, 184, 0.6);
        color: var(--chatbot-muted);
    }

    .chatbot-message-content h1,
    .chatbot-message-content h2,
    .chatbot-message-content h3,
    .chatbot-message-content h4,
    .chatbot-message-content h5,
    .chatbot-message-content h6 {
        margin: 0.5em 0 0.35em;
        font-weight: 700;
        line-height: 1.2;
    }

    .chatbot-message-content h1 { font-size: 1.1em; }
    .chatbot-message-content h2 { font-size: 1.05em; }
    .chatbot-message-content h3 { font-size: 1em; }

    .chatbot-message-content hr {
        border: 0;
        border-top: 1px solid rgba(148, 163, 184, 0.4);
        margin: 0.6em 0;
    }

    .chatbot-message-content pre {
        margin: 0.6em 0;
        padding: 8px 10px;
        border-radius: 10px;
        background: rgba(15, 23, 42, 0.08);
        font-size: 0.9em;
        overflow-x: auto;
        white-space: pre-wrap;
    }

    .chatbot-message-content code {
        background: rgba(15, 23, 42, 0.08);
        padding: 0 4px;
        border-radius: 6px;
        font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
    }

    .chatbot-message-content u {
        text-decoration: underline;
    }

    .chatbot-message-content .chatbot-spoiler {
        background: rgba(15, 23, 42, 0.15);
        color: transparent;
        border-radius: 6px;
        padding: 0 4px;
        box-shadow: inset 0 0 0 1px rgba(148, 163, 184, 0.4);
        cursor: pointer;
        transition: color 0.2s ease;
    }

    .chatbot-message-content .chatbot-spoiler:hover,
    .chatbot-message-content .chatbot-spoiler:focus {
        color: var(--chatbot-text);
    }

    .chatbot-message-content a {
        color: var(--chatbot-primary-strong);
        text-decoration: underline;
        word-break: break-word;
    }

    .chatbot-message.user .chatbot-message-content {
        background: var(--chatbot-bubble-user-bg);
        color: var(--chatbot-bubble-user-text);
        border-color: var(--chatbot-bubble-user-border);
    }

    .chatbot-message.user .chatbot-message-content blockquote {
        border-left-color: rgba(255, 255, 255, 0.6);
        color: rgba(255, 255, 255, 0.85);
    }

    .chatbot-message.user .chatbot-message-content pre,
    .chatbot-message.user .chatbot-message-content code {
        background: rgba(255, 255, 255, 0.2);
        color: #ffffff;
    }

    .chatbot-message.user .chatbot-message-content a {
        color: #e0f2fe;
    }

    .chatbot-message.user .chatbot-message-content .chatbot-spoiler {
        background: rgba(255, 255, 255, 0.25);
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.4);
    }

    .chatbot-message.typing {
        align-self: center;
        margin-left: auto;
        margin-right: auto;
        max-width: none;
    }

    .chatbot-message.typing .chatbot-message-content {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        padding: 10px 16px;
        flex-direction: row;
    }

    .typing-indicator span {
        height: 8px;
        width: 8px;
        background-color: rgba(37, 99, 235, 0.5);
        border-radius: 50%;
        display: inline-block;
        animation: chatbot-bounce 1.3s infinite ease-in-out both;
    }

    .typing-indicator span:nth-of-type(2) {
        animation-delay: 0.15s;
    }

    .typing-indicator span:nth-of-type(3) {
        animation-delay: 0.3s;
    }

    @keyframes chatbot-bounce {
        0%, 80%, 100% {
            transform: scale(0);
            opacity: 0.4;
        }
        40% {
            transform: scale(1);
            opacity: 1;
        }
    }

    @keyframes chatbot-spin {
        to {
            transform: rotate(360deg);
        }
    }

    .chatbot-image-viewer {
        position: fixed;
        inset: 0;
        display: none;
        align-items: center;
        justify-content: center;
        padding: 24px;
        background: rgba(15, 23, 42, 0.72);
        backdrop-filter: blur(2px);
        z-index: 9999;
    }

    .chatbot-image-viewer.is-open {
        display: flex;
    }

    .chatbot-image-viewer img {
        max-width: min(92vw, 860px);
        max-height: 88vh;
        width: auto;
        height: auto;
        border-radius: 16px;
        box-shadow: 0 20px 40px rgba(15, 23, 42, 0.35);
        background: #ffffff;
    }

    .chatbot-image-viewer__close {
        position: absolute;
        top: 16px;
        right: 16px;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        border: none;
        background: rgba(15, 23, 42, 0.6);
        color: #ffffff;
        font-size: 20px;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.2s ease;
    }

    .chatbot-image-viewer__close:hover {
        background: rgba(15, 23, 42, 0.8);
    }

    body.ai-chatbot-image-open {
        overflow: hidden;
    }

    .chatbot-input-area {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: var(--chatbot-input-area-padding-y) var(--chatbot-input-area-padding-x);
        border-top: 1px solid var(--chatbot-input-border);
        background: var(--chatbot-input-area-bg);
        backdrop-filter: blur(var(--chatbot-input-area-blur));
        -webkit-backdrop-filter: blur(var(--chatbot-input-area-blur));
        position: relative;
        z-index: 1;
    }

    .chatbot-input-area textarea,
    .chatbot-input-area input[type="text"] {
        flex: 1;
        border: 1px solid var(--chatbot-input-border);
        border-radius: 12px;
        padding: 10px 14px;
        font-size: 15px;
        color: var(--chatbot-input-text);
        outline: none;
        transition: border-color 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease;
        background-color: var(--chatbot-input-bg);
    }

    .chatbot-input-area textarea {
        min-height: 40px;
        max-height: 120px;
        resize: none;
        line-height: 1.35;
        overflow: auto;
        scrollbar-width: none;
        -ms-overflow-style: none;
    }

    .chatbot-input-area textarea::-webkit-scrollbar {
        width: 0;
        height: 0;
    }

    .chatbot-input-area textarea:focus,
    .chatbot-input-area input[type="text"]:focus {
        border-color: var(--chatbot-primary);
        box-shadow: var(--chatbot-ring);
        background-color: var(--chatbot-input-bg-focus);
    }

    .chatbot-input-area textarea::placeholder,
    .chatbot-input-area input[type="text"]::placeholder {
        color: var(--chatbot-muted);
    }

    .chatbot-input-area button {
        background: var(--chatbot-send-bg);
        color: var(--chatbot-send-text);
        border: none;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        min-width: 40px;
        min-height: 40px;
        aspect-ratio: 1 / 1;
        padding: 0;
        font-weight: 600;
        cursor: pointer;
        box-shadow: 0 10px 18px rgba(13, 148, 136, 0.25);
        transition: transform 0.2s ease, filter 0.2s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        position: relative;
        overflow: hidden;
    }

    .chatbot-input-area button svg {
        transition: opacity 0.2s ease;
    }

    .chatbot-input-area button .chatbot-send-spinner {
        position: absolute;
        inset: 0;
        margin: auto;
        width: 18px;
        height: 18px;
        border-radius: 50%;
        border: 2px solid rgba(255, 255, 255, 0.45);
        border-top-color: #ffffff;
        opacity: 0;
        animation: chatbot-spin 0.8s linear infinite;
        pointer-events: none;
    }

    .chatbot-input-area button.is-loading svg {
        opacity: 0;
    }

    .chatbot-input-area button.is-loading .chatbot-send-spinner {
        opacity: 1;
    }

    .chatbot-input-area button:hover:not([disabled]) {
        transform: translateY(-1px);
        filter: brightness(1.05);
    }

    .chatbot-input-area button:disabled {
        opacity: 0.6;
        cursor: not-allowed;
        transform: none;
    }

    .chatbot-input__label {
        position: absolute;
        width: 1px;
        height: 1px;
        padding: 0;
        margin: -1px;
        overflow: hidden;
        clip: rect(0, 0, 0, 0);
        border: 0;
    }

    body.dark-mode .ai-chatbot-root,
    .dark-mode .ai-chatbot-root,
    [data-theme="dark"] .ai-chatbot-root {
        --chatbot-primary: #60a5fa;
        --chatbot-primary-strong: #3b82f6;
        --chatbot-accent: #22d3ee;
        --chatbot-bg: #0b1220;
        --chatbot-surface: #0f172a;
        --chatbot-text: #e2e8f0;
        --chatbot-muted: #94a3b8;
        --chatbot-bubble-border: rgba(148, 163, 184, 0.25);
        --chatbot-header-bg-default: linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-accent));
        --chatbot-header-text-default: #ffffff;
        --chatbot-launcher-bg-default: linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-primary-strong));
        --chatbot-launcher-text-default: #ffffff;
        --chatbot-send-bg-default: linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-accent));
        --chatbot-send-text-default: #ffffff;
        --chatbot-frame-bg-default: linear-gradient(180deg, #0f172a 0%, #0b1220 100%);
        --chatbot-messages-bg-default: linear-gradient(180deg, #0b1220 0%, #111827 100%);
        --chatbot-input-bg-default: #0b1220;
        --chatbot-input-text-default: var(--chatbot-text);
        --chatbot-input-border-default: rgba(148, 163, 184, 0.35);
        --chatbot-input-area-bg-default: rgba(15, 23, 42, 0.85);
        --chatbot-shadow: 0 20px 45px rgba(2, 6, 23, 0.6);
        --chatbot-ring: 0 0 0 3px rgba(96, 165, 250, 0.35);
    }

    body.dark-mode .ai-chatbot-frame,
    .dark-mode .ai-chatbot-frame,
    [data-theme="dark"] .ai-chatbot-frame {
        border-color: rgba(148, 163, 184, 0.2);
    }

    body.dark-mode .ai-chatbot-frame::before,
    .dark-mode .ai-chatbot-frame::before,
    [data-theme="dark"] .ai-chatbot-frame::before {
        opacity: 0.35;
    }

    body.dark-mode .chatbot-messages,
    .dark-mode .chatbot-messages,
    [data-theme="dark"] .chatbot-messages {
        background: var(--chatbot-messages-bg);
    }

    body.dark-mode .chatbot-header__status,
    .dark-mode .chatbot-header__status,
    [data-theme="dark"] .chatbot-header__status {
        color: var(--chatbot-header-text);
        font-weight: 700;
        text-shadow: 0 1px 2px rgba(0, 0, 0, 0.35);
    }

    body.dark-mode .chatbot-header__status::before,
    .dark-mode .chatbot-header__status::before,
    [data-theme="dark"] .chatbot-header__status::before {
        box-shadow:
            0 0 0 3px rgba(34, 197, 94, 0.35),
            0 0 12px rgba(34, 197, 94, 0.35);
    }

    body.dark-mode .chatbot-header__status[data-status="checking"]::before,
    .dark-mode .chatbot-header__status[data-status="checking"]::before,
    [data-theme="dark"] .chatbot-header__status[data-status="checking"]::before {
        box-shadow:
            0 0 0 3px rgba(245, 158, 11, 0.4),
            0 0 12px rgba(245, 158, 11, 0.35);
    }

    body.dark-mode .chatbot-header__status[data-status="offline"]::before,
    .dark-mode .chatbot-header__status[data-status="offline"]::before,
    [data-theme="dark"] .chatbot-header__status[data-status="offline"]::before {
        box-shadow:
            0 0 0 3px rgba(239, 68, 68, 0.4),
            0 0 12px rgba(239, 68, 68, 0.35);
    }

    body.dark-mode .chatbot-message-content,
    .dark-mode .chatbot-message-content,
    [data-theme="dark"] .chatbot-message-content {
        box-shadow: 0 10px 18px rgba(2, 6, 23, 0.45);
    }

    body.dark-mode .chatbot-input-area,
    .dark-mode .chatbot-input-area,
    [data-theme="dark"] .chatbot-input-area {
        border-top-color: rgba(148, 163, 184, 0.25);
        background: rgba(15, 23, 42, 0.85);
    }

    body.dark-mode .chatbot-input-area textarea,
    .dark-mode .chatbot-input-area textarea,
    [data-theme="dark"] .chatbot-input-area textarea,
    body.dark-mode .chatbot-input-area input[type="text"],
    .dark-mode .chatbot-input-area input[type="text"],
    [data-theme="dark"] .chatbot-input-area input[type="text"] {
        background-color: var(--chatbot-input-bg);
    }

    body.dark-mode .chatbot-input-area textarea:focus,
    .dark-mode .chatbot-input-area textarea:focus,
    [data-theme="dark"] .chatbot-input-area textarea:focus,
    body.dark-mode .chatbot-input-area input[type="text"]:focus,
    .dark-mode .chatbot-input-area input[type="text"]:focus,
    [data-theme="dark"] .chatbot-input-area input[type="text"]:focus {
        background-color: var(--chatbot-input-bg-focus);
    }

    @media (prefers-color-scheme: dark) {
        .ai-chatbot-root {
            --chatbot-primary: #60a5fa;
            --chatbot-primary-strong: #3b82f6;
            --chatbot-accent: #22d3ee;
            --chatbot-bg: #0b1220;
            --chatbot-surface: #0f172a;
            --chatbot-text: #e2e8f0;
            --chatbot-muted: #94a3b8;
            --chatbot-header-bg-default: linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-accent));
            --chatbot-header-text-default: #ffffff;
            --chatbot-launcher-bg-default: linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-primary-strong));
            --chatbot-launcher-text-default: #ffffff;
            --chatbot-send-bg-default: linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-accent));
            --chatbot-send-text-default: #ffffff;
            --chatbot-frame-bg-default: linear-gradient(180deg, #0f172a 0%, #0b1220 100%);
            --chatbot-messages-bg-default: linear-gradient(180deg, #0b1220 0%, #111827 100%);
            --chatbot-input-bg-default: #0b1220;
            --chatbot-input-text-default: var(--chatbot-text);
            --chatbot-input-border-default: rgba(148, 163, 184, 0.35);
            --chatbot-input-area-bg-default: rgba(15, 23, 42, 0.85);
            --chatbot-shadow: 0 20px 45px rgba(2, 6, 23, 0.6);
            --chatbot-ring: 0 0 0 3px rgba(96, 165, 250, 0.35);
        }

        .ai-chatbot-frame {
            border-color: rgba(148, 163, 184, 0.2);
        }

        .ai-chatbot-frame::before {
            opacity: 0.35;
        }

        .chatbot-messages {
            background: var(--chatbot-messages-bg);
        }

        .chatbot-header__status {
            color: var(--chatbot-header-text);
            font-weight: 700;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.35);
        }

        .chatbot-header__status::before {
            box-shadow:
                0 0 0 3px rgba(34, 197, 94, 0.35),
                0 0 12px rgba(34, 197, 94, 0.35);
        }

        .chatbot-header__status[data-status="checking"]::before {
            box-shadow:
                0 0 0 3px rgba(245, 158, 11, 0.4),
                0 0 12px rgba(245, 158, 11, 0.35);
        }

        .chatbot-header__status[data-status="offline"]::before {
            box-shadow:
                0 0 0 3px rgba(239, 68, 68, 0.4),
                0 0 12px rgba(239, 68, 68, 0.35);
        }

        .chatbot-message-content {
            box-shadow: 0 10px 18px rgba(2, 6, 23, 0.45);
        }

        .chatbot-input-area {
            border-top-color: rgba(148, 163, 184, 0.25);
            background: rgba(15, 23, 42, 0.85);
        }

        .chatbot-input-area textarea,
        .chatbot-input-area input[type="text"] {
            background-color: var(--chatbot-input-bg);
        }

        .chatbot-input-area textarea:focus,
        .chatbot-input-area input[type="text"]:focus {
            background-color: var(--chatbot-input-bg-focus);
        }

        .chatbot-scroll-bottom {
            background: rgba(148, 163, 184, 0.16);
            color: #e2e8f0;
        }
    }

    @media (max-width: 720px) {
        .ai-chatbot-root {
            left: min(var(--chatbot-side-spacing), 20px);
            right: min(var(--chatbot-side-spacing), 20px);
            flex-direction: column-reverse;
            align-items: stretch;
        }

        .ai-chatbot-button {
            align-self: flex-end;
        }

        .ai-chatbot-frame {
            width: 100%;
            height: min(75vh, {$frame_height}px);
        }
    }

    @media (prefers-reduced-motion: reduce) {
        .ai-chatbot-frame.is-open,
        .chatbot-message,
        .ai-chatbot-button::after {
            animation: none;
            transition: none;
        }
    }

    @keyframes chatbot-frame-in {
        from {
            opacity: 0;
            transform: translateY(12px) scale(0.98);
        }
        to {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
    }

    @keyframes chatbot-message-in {
        from {
            opacity: 0;
            transform: translateY(6px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>

<div id="ai-chatbot-root" class="ai-chatbot-root ai-chatbot-root--{$button_side|escape}" data-enabled="{$chatbot_enabled}" data-title="{$chatbot_title|escape}">
    <button type="button" id="ai-chatbot-button" class="ai-chatbot-button" title="{$button_label|escape}" aria-label="{$button_label|escape}" aria-controls="ai-chatbot-frame" aria-expanded="false">
        <span class="ai-chatbot-button-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M21 15a2 2 0 0 1-2 2H8l-5 5V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
            </svg>
        </span>
        <span class="ai-chatbot-button-text">{$button_label|escape}</span>
    </button>
    <div id="ai-chatbot-frame" class="ai-chatbot-frame" data-frame-mode="{$frame_mode|escape}" role="dialog" aria-modal="false" aria-hidden="true" aria-label="{$chatbot_title|escape}">
        <div class="chatbot-header">
            <div class="chatbot-header__info">
                <div class="chatbot-header__title">
                    {if $chatbot.chatbot_avatar_url|trim ne ''}
                        <img src="{$chatbot.chatbot_avatar_url|escape}" alt="" class="chatbot-header__avatar" />
                    {else}
                        <span class="chatbot-header__avatar chatbot-header__avatar--placeholder">AI</span>
                    {/if}
                    <div class="chatbot-header__text">
                        <span class="chatbot-header__name">{$chatbot_title|escape}</span>
                        <span class="chatbot-header__status" data-status="checking">Checking...</span>
                    </div>
                </div>
            </div>
            <div class="chatbot-header__actions">
                {if $handoff_enabled == '1'}
                    <button type="button" class="chatbot-handoff" aria-label="{$handoff_label|escape}">{$handoff_label|escape}</button>
                {/if}
                <button type="button" class="chatbot-close" aria-label="Close chat">&times;</button>
            </div>
        </div>
        <div class="chatbot-messages" role="log" aria-live="polite"></div>
        <button type="button" class="chatbot-scroll-bottom" aria-label="Scroll to latest" title="Scroll to latest">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <line x1="12" y1="5" x2="12" y2="19"></line>
                <polyline points="19 12 12 19 5 12"></polyline>
            </svg>
            <span class="chatbot-scroll-bottom__label">Pesan Terbaru</span>
        </button>
        <form class="chatbot-input-area" autocomplete="off">
            <label class="chatbot-input__label" for="chatbot-input">Type your message</label>
            <textarea id="chatbot-input" name="chatbot-input" placeholder="Compose your message..." maxlength="{$chatbot.chatbot_user_input_max_chars|default:1000|intval}" rows="1" autocomplete="off"></textarea>
            <button type="submit" id="chatbot-send" aria-label="Send message">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="22" y1="2" x2="11" y2="13"></line>
                    <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
                </svg>
                <span class="chatbot-send-spinner" aria-hidden="true"></span>
            </button>
        </form>
    </div>
</div>

<div id="chatbot-image-viewer" class="chatbot-image-viewer" aria-hidden="true" role="dialog">
    <img src="" alt="Chatbot image preview" />
    <button type="button" class="chatbot-image-viewer__close" aria-label="Close image">&times;</button>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const root = document.getElementById('ai-chatbot-root');
    if (!root || root.dataset.initialized === '1') {
        return;
    }
    root.dataset.initialized = '1';

    if (root.dataset.enabled !== '1') {
        root.style.display = 'none';
        return;
    }

    const chatButton = document.getElementById('ai-chatbot-button');
    const chatFrame = document.getElementById('ai-chatbot-frame');
    const closeButton = chatFrame ? chatFrame.querySelector('.chatbot-close') : null;
    const handoffButton = chatFrame ? chatFrame.querySelector('.chatbot-handoff') : null;
    const messagesContainer = chatFrame ? chatFrame.querySelector('.chatbot-messages') : null;
    const scrollButton = chatFrame ? chatFrame.querySelector('.chatbot-scroll-bottom') : null;
    const form = chatFrame ? chatFrame.querySelector('.chatbot-input-area') : null;
    const input = document.getElementById('chatbot-input');
    const sendButton = document.getElementById('chatbot-send');
    const statusEl = chatFrame ? chatFrame.querySelector('.chatbot-header__status') : null;
    const avatarImg = chatFrame ? chatFrame.querySelector('.chatbot-header__avatar') : null;
    const imageViewer = document.getElementById('chatbot-image-viewer');
    const imageViewerImg = imageViewer ? imageViewer.querySelector('img') : null;
    const imageViewerClose = imageViewer ? imageViewer.querySelector('.chatbot-image-viewer__close') : null;

    if (!chatButton || !chatFrame || !closeButton || !messagesContainer || !form || !input || !sendButton) {
        console.error('AI Chatbot: required markup is missing.');
        root.style.display = 'none';
        return;
    }

    input.disabled = true;
    sendButton.disabled = true;

    const pageContext = "{if isset($_admin) && $_admin}admin{elseif isset($_user) && $_user}customer{/if}";
    const contextParam = pageContext ? '&context=' + encodeURIComponent(pageContext) : '';
    const bootstrapUrl = "{$app_url|escape:'javascript'}?_route=plugin/ai_chatbot_settings/bootstrap" + contextParam;
    const statusUrl = "{$app_url|escape:'javascript'}?_route=plugin/ai_chatbot_settings/status" + contextParam;
    const streamUrl = "{$app_url|escape:'javascript'}?_route=plugin/ai_chatbot_settings/stream" + contextParam;
    let chatConfig = {};
    let history = [];
    let csrfToken = null;
    let statusCheckInFlight = false;
    let lastStatusCheckedAt = 0;
    let handoffInFlight = false;
    let handoffActive = false;
    let handoffStorageKey = null;
    let baseStatusState = 'checking';
    let baseStatusLabel = 'Checking...';
    let sseSource = null;
    let sseInfo = null;

    const visitorIdKey = 'ai_chatbot_visitor_id';
    const sessionIdKey = 'ai_chatbot_session_id';
    const historyModeRaw = "{$chatbot.chatbot_history_mode|default:'ttl'|escape:'javascript'}";
    const historyTtlMinutesRaw = parseInt("{$chatbot.chatbot_history_ttl|default:360|escape:'javascript'}", 10);
    const historyMaxRaw = parseInt("{$chatbot.chatbot_history_max_messages|default:50|escape:'javascript'}", 10);
    const welcomeEnabledRaw = "{$chatbot.chatbot_welcome_enabled|default:'0'|escape:'javascript'}";
    const welcomeMessage = "{$chatbot.chatbot_welcome_message|default:'Hello! How can I help you today?'|escape:'javascript'}";
    const typingModeRaw = "{$chatbot.chatbot_typing_mode|default:'off'|escape:'javascript'}";
    const typingWpmRaw = parseInt("{$chatbot.chatbot_typing_wpm|default:300|escape:'javascript'}", 10);
    const frameModeRaw = "{$chatbot.chatbot_frame_mode|default:'fixed'|escape:'javascript'}";
    const statusThrottleSecondsRaw = parseInt("{$chatbot.chatbot_status_throttle|default:30|escape:'javascript'}", 10);
    const responseKeyRaw = "{$chatbot.chatbot_response_key|default:''|escape:'javascript'}";
    const messageFormatRaw = "{$chatbot.chatbot_message_format|default:'markdown'|escape:'javascript'}";
    const handoffEnabledRaw = "{$chatbot.chatbot_handoff_enabled|default:'0'|escape:'javascript'}";
    const handoffLabelRaw = "{$handoff_label|escape:'javascript'}";
    const handoffTimeoutRaw = parseInt("{$chatbot.chatbot_handoff_timeout|default:600|escape:'javascript'}", 10);
    const handoffReasonRaw = "{$chatbot.chatbot_handoff_reason|default:'chat_dengan_admin'|escape:'javascript'}";
    const handoffNoticeRaw = "{$chatbot.chatbot_handoff_notice|default:'Permintaan terkirim. Admin akan segera bergabung.'|escape:'javascript'}";
    const metaScopeOverrideRaw = "{$chatbot.chatbot_meta_scope|default:''|escape:'javascript'}";
    const metaEntityOverrideRaw = "{$chatbot.chatbot_meta_entity_id|default:''|escape:'javascript'}";
    const metaOwnerOverrideRaw = "{$chatbot.chatbot_meta_owner_id|default:''|escape:'javascript'}";

    const settings = {
        history_mode: historyModeRaw === 'count' ? 'count' : 'ttl',
        history_ttl: !isNaN(historyTtlMinutesRaw) && historyTtlMinutesRaw > 0 ? historyTtlMinutesRaw * 60 * 1000 : 360 * 60 * 1000,
        history_max_messages: !isNaN(historyMaxRaw) && historyMaxRaw > 0 ? historyMaxRaw : 50,
        welcome_enabled: welcomeEnabledRaw === '1',
        welcome_message: welcomeMessage
    };

    const typingMode = typingModeRaw === 'wpm' ? 'wpm' : 'off';
    const typingWpm = !isNaN(typingWpmRaw) && typingWpmRaw > 0 ? typingWpmRaw : 300;
    const frameMode = frameModeRaw === 'auto' ? 'auto' : 'fixed';
    const statusThrottleSeconds = !isNaN(statusThrottleSecondsRaw) && statusThrottleSecondsRaw >= 0
        ? statusThrottleSecondsRaw
        : 30;
    const statusThrottleMs = statusThrottleSeconds * 1000;
    const responseKey = responseKeyRaw ? responseKeyRaw.trim() : '';
    const messageFormat = messageFormatRaw === 'plain'
        ? 'plain'
        : (messageFormatRaw === 'markdown_v2' ? 'markdown_v2' : 'markdown');
    const handoffEnabled = handoffEnabledRaw === '1';
    const handoffLabel = handoffLabelRaw ? handoffLabelRaw.trim() : 'Chat dengan Admin';
    const handoffTimeout = !isNaN(handoffTimeoutRaw) && handoffTimeoutRaw >= 0 ? handoffTimeoutRaw : 600;
    const handoffReason = handoffReasonRaw ? handoffReasonRaw.trim() : 'chat_dengan_admin';
    const handoffNotice = handoffNoticeRaw ? handoffNoticeRaw.trim() : '';
    const metaScopeOverride = metaScopeOverrideRaw ? metaScopeOverrideRaw.trim() : '';
    const metaEntityOverride = metaEntityOverrideRaw ? metaEntityOverrideRaw.trim() : '';
    const metaOwnerOverride = metaOwnerOverrideRaw ? metaOwnerOverrideRaw.trim() : '';

    if (chatFrame) {
        chatFrame.dataset.frameMode = frameMode;
    }

    function applyStatus(state, label) {
        if (!statusEl) {
            return;
        }
        statusEl.dataset.status = state;
        statusEl.textContent = label;
        statusEl.classList.toggle('is-handoff', state === 'handoff');
    }

    function setStatus(state, label) {
        baseStatusState = state;
        baseStatusLabel = label;
        if (!handoffActive) {
            applyStatus(state, label);
        }
    }

    function setSendLoading(isLoading) {
        if (!sendButton) {
            return;
        }
        sendButton.classList.toggle('is-loading', isLoading);
        sendButton.setAttribute('aria-busy', isLoading ? 'true' : 'false');
    }

    function setHandoffActive(isActive) {
        if (!handoffEnabled) {
            handoffActive = false;
            if (root) {
                root.dataset.handoffActive = '0';
            }
            updateHandoffUI();
            stopSse(true);
            return;
        }
        handoffActive = Boolean(isActive);
        if (root) {
            root.dataset.handoffActive = handoffActive ? '1' : '0';
        }
        if (handoffButton) {
            handoffButton.classList.toggle('is-active', handoffActive);
        }
        updateHandoffUI();
        if (!handoffActive) {
            stopSse(true);
        }
        if (handoffStorageKey) {
            try {
                if (handoffActive) {
                    localStorage.setItem(handoffStorageKey, '1');
                } else {
                    localStorage.removeItem(handoffStorageKey);
                }
            } catch (error) {
                // ignore storage errors
            }
        }
    }

    function updateHandoffUI() {
        if (handoffActive) {
            applyStatus('handoff', 'Admin Terhubung');
        } else {
            applyStatus(baseStatusState, baseStatusLabel);
        }
        if (handoffButton) {
            const label = handoffActive ? 'Akhiri Percakapan' : handoffLabel;
            handoffButton.textContent = label;
            handoffButton.setAttribute('aria-label', label);
        }
    }

    function stopSse(clearInfo = false) {
        if (sseSource) {
            sseSource.close();
            sseSource = null;
        }
        if (clearInfo) {
            sseInfo = null;
        }
    }

    function parseJsonSafe(payload) {
        if (!payload) {
            return null;
        }
        try {
            return JSON.parse(payload);
        } catch (error) {
            return null;
        }
    }

    function handleSseMessage(event) {
        const payload = parseJsonSafe(event.data);
        if (!payload || typeof payload !== 'object') {
            return;
        }
        if (payload.event === 'handoff_off') {
            setHandoffActive(false);
            stopSse(true);
            return;
        }
        const text = payload.body || payload.text || payload.message || payload.chatInput;
        if (!text) {
            return;
        }
        addMessage('bot', text);
        history.push({ sender: 'bot', text: text });
        saveHistory();
    }

    function handleSseHandoffOff() {
        setHandoffActive(false);
        stopSse(true);
    }

    function handleSseError() {
        if (!sseSource) {
            return;
        }
        if (sseSource.readyState === EventSource.CLOSED) {
            stopSse(false);
        }
    }

    function startSse(transport) {
        if (!transport || typeof transport !== 'object') {
            return;
        }
        if (!handoffEnabled || !handoffActive) {
            return;
        }
        const mode = (transport.mode || '').toString().toLowerCase();
        if (mode !== 'sse') {
            return;
        }
        const token = transport.token ? String(transport.token) : '';
        const sessionId = transport.session_id ? String(transport.session_id) : (sessionToken || '');
        if (!token || !sessionId) {
            return;
        }
        if (sseInfo && sseInfo.token === token && sseInfo.sessionId === sessionId && sseSource) {
            return;
        }
        sseInfo = { token: token, sessionId: sessionId };
        const url = streamUrl + '&session_id=' + encodeURIComponent(sessionId) + '&token=' + encodeURIComponent(token);
        stopSse(false);
        try {
            sseSource = new EventSource(url);
        } catch (error) {
            sseSource = null;
            return;
        }
        sseSource.addEventListener('message', handleSseMessage);
        sseSource.addEventListener('handoff_off', handleSseHandoffOff);
        sseSource.addEventListener('error', handleSseError);
    }

    function syncTransportFromResponse(data) {
        if (!data || typeof data !== 'object') {
            return;
        }
        if (!handoffEnabled || !handoffActive) {
            return;
        }
        const transport = data.transport;
        if (!transport || typeof transport !== 'object') {
            return;
        }
        startSse(transport);
    }

    function syncHandoffStateFromResponse(data) {
        if (!handoffEnabled || !data || typeof data !== 'object') {
            return;
        }
        const info = data.handoff;
        if (!info || typeof info !== 'object') {
            return;
        }
        if (info.timeout) {
            const wasActive = handoffActive;
            setHandoffActive(false);
            if (wasActive) {
                sendHandoffOff();
            }
        } else if (info.bound) {
            setHandoffActive(true);
        }
    }

    function parseRgb(value) {
        if (!value) {
            return null;
        }
        const match = value.match(/rgba?\(\s*([0-9]+)\s*,\s*([0-9]+)\s*,\s*([0-9]+)(?:\s*,\s*([0-9.]+))?\s*\)/i);
        if (!match) {
            return null;
        }
        return {
            r: parseInt(match[1], 10),
            g: parseInt(match[2], 10),
            b: parseInt(match[3], 10),
            a: match[4] !== undefined ? parseFloat(match[4]) : 1
        };
    }

    function relativeLuminance(rgb) {
        if (!rgb) {
            return 0;
        }
        const toLinear = (channel) => {
            const c = channel / 255;
            return c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4);
        };
        const r = toLinear(rgb.r);
        const g = toLinear(rgb.g);
        const b = toLinear(rgb.b);
        return 0.2126 * r + 0.7152 * g + 0.0722 * b;
    }

    function contrastRatio(l1, l2) {
        const light = Math.max(l1, l2);
        const dark = Math.min(l1, l2);
        return (light + 0.05) / (dark + 0.05);
    }

    function ensureInputContrast() {
        if (!input) {
            return;
        }
        const styles = getComputedStyle(input);
        const fg = parseRgb(styles.color);
        let bg = parseRgb(styles.backgroundColor);
        if (!bg || bg.a < 0.15) {
            const area = input.closest('.chatbot-input-area');
            if (area) {
                const areaBg = parseRgb(getComputedStyle(area).backgroundColor);
                if (areaBg && areaBg.a >= 0.15) {
                    bg = areaBg;
                }
            }
        }
        if (!bg || bg.a < 0.15) {
            const frameBg = chatFrame ? parseRgb(getComputedStyle(chatFrame).backgroundColor) : null;
            if (frameBg && frameBg.a >= 0.15) {
                bg = frameBg;
            }
        }
        if (!fg || !bg) {
            return;
        }
        const ratio = contrastRatio(relativeLuminance(fg), relativeLuminance(bg));
        if (ratio >= 4.5) {
            input.style.removeProperty('color');
            input.style.removeProperty('caret-color');
            return;
        }
        const fallback = relativeLuminance(bg) > 0.5 ? 'rgb(15, 23, 42)' : 'rgb(226, 232, 240)';
        input.style.setProperty('color', fallback, 'important');
        input.style.setProperty('caret-color', fallback, 'important');
    }

    function isNearBottom() {
        if (!messagesContainer) {
            return true;
        }
        const gap = messagesContainer.scrollHeight - messagesContainer.scrollTop - messagesContainer.clientHeight;
        return gap < 120;
    }

    function updateScrollButton() {
        if (!scrollButton) {
            return;
        }
        scrollButton.classList.toggle('is-visible', !isNearBottom());
    }

    function scrollToBottom(behavior = 'smooth') {
        if (!messagesContainer) {
            return;
        }
        messagesContainer.scrollTo({
            top: messagesContainer.scrollHeight,
            behavior: behavior
        });
        updateScrollButton();
    }

    function openImageViewer(src) {
        if (!imageViewer || !imageViewerImg || !src) {
            return;
        }
        imageViewerImg.src = src;
        imageViewer.classList.add('is-open');
        imageViewer.setAttribute('aria-hidden', 'false');
        document.body.classList.add('ai-chatbot-image-open');
    }

    function closeImageViewer() {
        if (!imageViewer) {
            return;
        }
        imageViewer.classList.remove('is-open');
        imageViewer.setAttribute('aria-hidden', 'true');
        if (imageViewerImg) {
            imageViewerImg.src = '';
        }
        document.body.classList.remove('ai-chatbot-image-open');
    }

    async function checkStatus() {
        if (!statusEl || statusCheckInFlight) {
            return;
        }

        const now = Date.now();
        if (statusThrottleMs > 0 && now - lastStatusCheckedAt < statusThrottleMs) {
            return;
        }

        statusCheckInFlight = true;
        lastStatusCheckedAt = now;
        setStatus('checking', 'Checking...');

        try {
            const response = await fetch(statusUrl, {
                method: 'GET',
                credentials: 'same-origin',
                cache: 'no-store'
            });
            const data = await response.json();
            if (data && (data.status === 'online' || data.status === 'offline')) {
                const label = data.status === 'online' ? 'Online' : 'Offline';
                setStatus(data.status, label);
            } else {
                setStatus('offline', 'Offline');
            }
        } catch (error) {
            setStatus('offline', 'Offline');
        } finally {
            statusCheckInFlight = false;
        }
    }

    function uuidv4() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            const r = Math.random() * 16 | 0;
            const v = c === 'x' ? r : ((r & 0x3) | 0x8);
            return v.toString(16);
        });
    }

    function getVisitorId() {
        try {
            let visitorId = localStorage.getItem(visitorIdKey);
            if (!visitorId) {
                visitorId = uuidv4();
                localStorage.setItem(visitorIdKey, visitorId);
            }
            return visitorId;
        } catch (error) {
            return uuidv4();
        }
    }

    function getSessionId() {
        const fallback = () => {
            if (!window.__aiChatbotEphemeralSessionId) {
                window.__aiChatbotEphemeralSessionId = uuidv4();
            }
            return window.__aiChatbotEphemeralSessionId;
        };

        try {
            const storage = window.sessionStorage;
            if (!storage) {
                throw new Error('sessionStorage unavailable');
            }
            let sessionId = storage.getItem(sessionIdKey);
            if (!sessionId) {
                sessionId = uuidv4();
                storage.setItem(sessionIdKey, sessionId);
            }
            return sessionId;
        } catch (error) {
            return fallback();
        }
    }

    const visitorId = getVisitorId();
    const sessionIdRaw = getSessionId();
    const sessionFingerprint = (sessionIdRaw || '').replace(/[^a-f0-9]/gi, '').toLowerCase();
    const sessionToken = sessionFingerprint !== '' ? sessionFingerprint : null;
    const baseHistoryKey = 'ai_chatbot_history_' + visitorId;
    const historyKey = sessionFingerprint ? baseHistoryKey + '_' + sessionFingerprint : baseHistoryKey;
    handoffStorageKey = sessionFingerprint
        ? 'ai_chatbot_handoff_' + sessionFingerprint
        : 'ai_chatbot_handoff_' + visitorId;

    try {
        const legacyKeys = [
            'ai_chatbot_history',
            'ai_chatbot_history_' + visitorId
        ];
        if (!localStorage.getItem(historyKey)) {
            for (const legacyKey of legacyKeys) {
                const legacyValue = localStorage.getItem(legacyKey);
                if (legacyValue) {
                    localStorage.setItem(historyKey, legacyValue);
                    break;
                }
            }
        }
    } catch (error) {
        // ignore storage migration errors
    }

    function loadHistory() {
        let saved;
        try {
            saved = localStorage.getItem(historyKey);
        } catch (e) {
            return;
        }
        if (!saved) {
            return;
        }
        try {
            const data = JSON.parse(saved);
            const storedSessionId = typeof data.sessionId === 'string' ? data.sessionId : '';
            if (sessionFingerprint && storedSessionId && storedSessionId !== sessionFingerprint) {
                localStorage.removeItem(historyKey);
                return;
            }

            const storedVisitorId = typeof data.visitorId === 'string' ? data.visitorId : '';
            if (storedVisitorId && storedVisitorId !== visitorId) {
                localStorage.removeItem(historyKey);
                return;
            }
            if (settings.history_mode === 'ttl' && data.timestamp && Date.now() - data.timestamp > settings.history_ttl) {
                localStorage.removeItem(historyKey);
                return;
            }
            history = Array.isArray(data.messages) ? data.messages : [];
            history.forEach((msg) => addMessage(msg.sender, msg.text));
        } catch (error) {
            localStorage.removeItem(historyKey);
        }
    }

    function saveHistory() {
        try {
            if (settings.history_mode === 'count' && history.length > settings.history_max_messages) {
                history = history.slice(history.length - settings.history_max_messages);
            }
            const payload = {
                timestamp: Date.now(),
                messages: history
            };

            if (visitorId) {
                payload.visitorId = visitorId;
            }

            if (sessionToken) {
                payload.sessionId = sessionToken;
            }

            localStorage.setItem(historyKey, JSON.stringify(payload));
        } catch (error) {
            // ignore storage write errors
        }
    }

    function attachCopyButton(messageDiv) {
        if (!messageDiv || !messageDiv.classList.contains('bot')) {
            return;
        }
        const button = document.createElement('button');
        button.type = 'button';
        button.className = 'chatbot-copy-btn';
        button.setAttribute('aria-label', 'Copy message');
        button.setAttribute('title', 'Copy');
        button.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="9" y="9" width="13" height="13" rx="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>';
        messageDiv.appendChild(button);
    }

    function addMessage(sender, text, isTyping = false) {
        const messageDiv = document.createElement('div');
        messageDiv.classList.add('chatbot-message', sender);
        if (isTyping) {
            messageDiv.classList.add('typing');
        }

        const contentDiv = document.createElement('div');
        contentDiv.classList.add('chatbot-message-content');

        if (isTyping) {
            contentDiv.innerHTML = '<div class="typing-indicator"><span></span><span></span><span></span></div>';
        } else {
            const messageText = text || '';
            if (messageFormat === 'markdown') {
                contentDiv.innerHTML = renderMarkdown(messageText, renderInline);
            } else if (messageFormat === 'markdown_v2') {
                contentDiv.innerHTML = renderMarkdown(messageText, renderInlineV2);
            } else {
                contentDiv.textContent = messageText;
            }
        }

        messageDiv.appendChild(contentDiv);
        if (!isTyping) {
            attachCopyButton(messageDiv);
        }
        messagesContainer.appendChild(messageDiv);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
        updateScrollButton();
        updateAutoHeight();
        return messageDiv;
    }

    function restoreHandoffState() {
        if (!handoffEnabled || !handoffStorageKey) {
            return;
        }
        try {
            if (localStorage.getItem(handoffStorageKey) === '1') {
                setHandoffActive(true);
            }
        } catch (error) {
            // ignore storage errors
        }
    }

    function escapeHtml(value) {
        return String(value || '')
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    function renderInline(raw) {
        const linkTokens = [];
        let text = String(raw || '');

        text = text.replace(/\[([^\]]+)\]\((https?:\/\/[^\s)]+)\)/g, function (match, label, url) {
            const token = '@@LINKTOKEN' + linkTokens.length + '@@';
            linkTokens.push({ label: label, url: url });
            return token;
        });

        text = escapeHtml(text);
        text = text.replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>');
        text = text.replace(/__(.+?)__/g, '<strong>$1</strong>');
        text = text.replace(/\*(.+?)\*/g, '<em>$1</em>');
        text = text.replace(/_(.+?)_/g, '<em>$1</em>');
        text = text.replace(/~~(.+?)~~/g, '<del>$1</del>');
        text = text.replace(/(https?:\/\/[^\s<]+)/g, '<a href="$1" target="_blank" rel="noopener noreferrer">$1</a>');

        if (linkTokens.length) {
            text = text.replace(/@@LINKTOKEN(\d+)@@/g, function (match, index) {
                const token = linkTokens[parseInt(index, 10)];
                if (!token) {
                    return match;
                }
                return '<a href="' + token.url + '" target="_blank" rel="noopener noreferrer">' + escapeHtml(token.label) + '</a>';
            });
        }

        return text;
    }

    function renderInlineV2(raw) {
        const linkTokens = [];
        let text = String(raw || '');

        text = text.replace(/\[([^\]]+)\]\((https?:\/\/[^\s)]+)\)/g, function (match, label, url) {
            const token = '@@LINKTOKEN' + linkTokens.length + '@@';
            linkTokens.push({ label: label, url: url });
            return token;
        });

        text = escapeHtml(text);
        text = text.replace(/__([^_]+?)__/g, '<u>$1</u>');
        text = text.replace(/\*\*([^*]+?)\*\*/g, '<strong>$1</strong>');
        text = text.replace(/\*([^*]+?)\*/g, '<strong>$1</strong>');
        text = text.replace(/_([^_]+?)_/g, '<em>$1</em>');
        text = text.replace(/~~([^~]+?)~~/g, '<del>$1</del>');
        text = text.replace(/~([^~]+?)~/g, '<del>$1</del>');
        text = text.replace(/\|\|([\s\S]+?)\|\|/g, '<span class="chatbot-spoiler">$1</span>');
        text = text.replace(/(https?:\/\/[^\s<]+)/g, '<a href="$1" target="_blank" rel="noopener noreferrer">$1</a>');

        if (linkTokens.length) {
            text = text.replace(/@@LINKTOKEN(\d+)@@/g, function (match, index) {
                const token = linkTokens[parseInt(index, 10)];
                if (!token) {
                    return match;
                }
                return '<a href="' + token.url + '" target="_blank" rel="noopener noreferrer">' + escapeHtml(token.label) + '</a>';
            });
        }

        return text;
    }

    function renderMarkdown(raw, inlineRenderer) {
        if (typeof inlineRenderer !== 'function') {
            inlineRenderer = renderInline;
        }
        const source = String(raw || '').replace(/\r\n/g, '\n');
        const codeBlocks = [];
        const inlineCodes = [];
        let text = source;

        text = text.replace(/```([\s\S]*?)```/g, function (match, code) {
            const token = '@@CODEBLOCK' + codeBlocks.length + '@@';
            codeBlocks.push(code);
            return token;
        });

        text = text.replace(/`([^`]+)`/g, function (match, code) {
            const token = '@@INLINECODE' + inlineCodes.length + '@@';
            inlineCodes.push(code);
            return token;
        });

        const lines = text.split('\n');
        let html = '';
        let inUl = false;
        let inOl = false;
        let inBlockquote = false;

        function closeLists() {
            if (inUl) {
                html += '</ul>';
                inUl = false;
            }
            if (inOl) {
                html += '</ol>';
                inOl = false;
            }
        }

        function closeBlockquote() {
            if (inBlockquote) {
                html += '</blockquote>';
                inBlockquote = false;
            }
        }

        lines.forEach(function (line) {
            const trimmed = line.trim();
            if (trimmed === '') {
                closeLists();
                closeBlockquote();
                html += '<br>';
                return;
            }

            const headingMatch = line.match(/^\s*#+\s+(.*)$/);
            if (headingMatch) {
                closeLists();
                closeBlockquote();
                const hashMatch = line.match(/^\s*#+/);
                const level = hashMatch ? hashMatch[0].trim().length : 1;
                const content = headingMatch[1] || '';
                html += '<h' + level + '>' + inlineRenderer(content) + '</h' + level + '>';
                return;
            }

            if (/^\s*([-*_])\1\1+\s*$/.test(line)) {
                closeLists();
                closeBlockquote();
                html += '<hr>';
                return;
            }

            if (/^\s*>\s?/.test(line)) {
                closeLists();
                if (!inBlockquote) {
                    html += '<blockquote>';
                    inBlockquote = true;
                }
                const content = line.replace(/^\s*>\s?/, '');
                html += '<p>' + inlineRenderer(content) + '</p>';
                return;
            }

            if (/^\s*\d+\.\s+/.test(line)) {
                if (!inOl) {
                    closeLists();
                    closeBlockquote();
                    html += '<ol>';
                    inOl = true;
                }
                const content = line.replace(/^\s*\d+\.\s+/, '');
                html += '<li>' + inlineRenderer(content) + '</li>';
                return;
            }

            if (/^\s*[-*]\s+/.test(line)) {
                if (!inUl) {
                    closeLists();
                    closeBlockquote();
                    html += '<ul>';
                    inUl = true;
                }
                const content = line.replace(/^\s*[-*]\s+/, '');
                html += '<li>' + inlineRenderer(content) + '</li>';
                return;
            }

            closeLists();
            closeBlockquote();
            html += '<p>' + inlineRenderer(line) + '</p>';
        });

        closeLists();
        closeBlockquote();

        html = html.replace(/@@INLINECODE(\d+)@@/g, function (match, index) {
            const code = inlineCodes[parseInt(index, 10)];
            return '<code>' + escapeHtml(code || '') + '</code>';
        });

        html = html.replace(/@@CODEBLOCK(\d+)@@/g, function (match, index) {
            const code = codeBlocks[parseInt(index, 10)];
            return '<pre><code>' + escapeHtml(code || '') + '</code></pre>';
        });

        return html;
    }

    function getMessagePlainText(messageEl) {
        if (!messageEl) {
            return '';
        }
        const content = messageEl.querySelector('.chatbot-message-content');
        if (!content) {
            return '';
        }
        const clone = content.cloneNode(true);
        clone.querySelectorAll('.chatbot-copy-btn').forEach((btn) => btn.remove());
        const text = clone.innerText || clone.textContent || '';
        return text.replace(/\n\n\n+/g, '\n\n').trim();
    }

    function copyToClipboard(text) {
        if (!text) {
            return Promise.resolve();
        }
        if (navigator.clipboard && window.isSecureContext) {
            return navigator.clipboard.writeText(text);
        }
        return new Promise((resolve, reject) => {
            const textarea = document.createElement('textarea');
            textarea.value = text;
            textarea.setAttribute('readonly', '');
            textarea.style.position = 'fixed';
            textarea.style.left = '-9999px';
            document.body.appendChild(textarea);
            textarea.select();
            try {
                const success = document.execCommand('copy');
                document.body.removeChild(textarea);
                if (success) {
                    resolve();
                } else {
                    reject(new Error('copy_failed'));
                }
            } catch (error) {
                document.body.removeChild(textarea);
                reject(error);
            }
        });
    }

    function updateAutoHeight() {
        if (frameMode !== 'auto' || !chatFrame) {
            return;
        }

        chatFrame.style.height = 'auto';
        const maxHeight = Math.floor(window.innerHeight * 0.8);
        const nextHeight = Math.min(chatFrame.scrollHeight, maxHeight);
        chatFrame.style.height = nextHeight + 'px';
    }

    function typingDelayForText(text) {
        if (typingMode !== 'wpm') {
            return 0;
        }

        const content = (text || '').trim();
        if (content === '') {
            return 0;
        }

        const msPerChar = 60000 / (typingWpm * 5);
        const estimated = Math.round(content.length * msPerChar);
        return Math.min(8000, Math.max(300, estimated));
    }

    function setChatOpen(open) {
        if (open) {
            root.classList.add('ai-chatbot-root--open');
            chatFrame.classList.add('is-open');
            chatFrame.setAttribute('aria-hidden', 'false');
            chatButton.setAttribute('aria-expanded', 'true');

            checkStatus();
            ensureInputContrast();
            updateScrollButton();

            if (history.length === 0 && settings.welcome_enabled) {
                const welcomeMessageText = settings.welcome_message || '';
                if (welcomeMessageText !== '') {
                    addMessage('bot', welcomeMessageText);
                    history.push({ sender: 'bot', text: welcomeMessageText });
                    saveHistory();
                }
            }

            requestAnimationFrame(() => {
                updateAutoHeight();
                input.focus();
            });
        } else {
            root.classList.remove('ai-chatbot-root--open');
            chatFrame.classList.remove('is-open');
            chatFrame.setAttribute('aria-hidden', 'true');
            chatButton.setAttribute('aria-expanded', 'false');
        }
    }

    function toggleChat(event) {
        if (event) {
            event.preventDefault();
        }
        const isOpen = chatFrame.classList.contains('is-open');
        setChatOpen(!isOpen);
    }

    function closeChat(event) {
        if (event) {
            event.preventDefault();
        }
        setChatOpen(false);
    }

    function handleDocumentClick(event) {
        if (!chatFrame.classList.contains('is-open')) {
            return;
        }
        if (imageViewer && imageViewer.classList.contains('is-open')) {
            return;
        }
        if (!root.contains(event.target)) {
            setChatOpen(false);
        }
    }

    function handleKeydown(event) {
        if (event.key !== 'Escape') {
            return;
        }

        if (imageViewer && imageViewer.classList.contains('is-open')) {
            closeImageViewer();
            return;
        }

        if (chatFrame.classList.contains('is-open')) {
            setChatOpen(false);
        }
    }

    function getByPath(payload, path) {
        if (!payload || typeof payload !== 'object' || !path) {
            return undefined;
        }
        const parts = path.split('.').filter(Boolean);
        let current = payload;
        for (const part of parts) {
            if (current && Object.prototype.hasOwnProperty.call(current, part)) {
                current = current[part];
            } else {
                return undefined;
            }
        }
        return current;
    }

    function extractBotMessage(payload, skipResponseKey = false) {
        if (payload === null || payload === undefined) {
            return '';
        }

        if (!skipResponseKey && responseKey) {
            const keyed = getByPath(payload, responseKey);
            if (keyed !== undefined) {
                const candidate = extractBotMessage(keyed, true);
                if (candidate) {
                    return candidate;
                }
            }
        }

        if (typeof payload === 'string') {
            return payload;
        }

        if (Array.isArray(payload)) {
            for (const item of payload) {
                const candidate = extractBotMessage(item);
                if (candidate) {
                    return candidate;
                }
            }
            return '';
        }

        if (typeof payload === 'object') {
            const directKeys = ['response', 'output', 'message', 'text', 'content', 'answer'];
            for (const key of directKeys) {
                if (Object.prototype.hasOwnProperty.call(payload, key)) {
                    const candidate = extractBotMessage(payload[key]);
                    if (candidate) {
                        return candidate;
                    }
                }
            }

            if (payload.choices && Array.isArray(payload.choices)) {
                for (const choice of payload.choices) {
                    const candidate = extractBotMessage(choice, true);
                    if (candidate) {
                        return candidate;
                    }
                }
            }

            if (payload.data !== undefined) {
                const candidate = extractBotMessage(payload.data, true);
                if (candidate) {
                    return candidate;
                }
            }

            const numericKeys = Object.keys(payload)
                .filter((key) => /^[0-9]+$/.test(key))
                .sort((a, b) => parseInt(a, 10) - parseInt(b, 10));

            for (const key of numericKeys) {
                const candidate = extractBotMessage(payload[key], true);
                if (candidate) {
                    return candidate;
                }
            }
        }

        return '';
    }

    async function sendMessage() {
        const rawText = input.value;
        const text = rawText.trim();
        if (text === '' || !chatConfig.proxy_url) {
            return;
        }
        const cleanedText = rawText.replace(/\r\n/g, '\n').trim();
        const isHandoffMode = handoffEnabled && handoffActive;

        addMessage('user', cleanedText);
        history.push({ sender: 'user', text: cleanedText });
        saveHistory();

        input.value = '';
        input.disabled = true;
        sendButton.disabled = true;
        setSendLoading(true);

        const typingIndicator = typingMode === 'wpm' ? addMessage('bot', '', true) : null;

        try {
            const requestId = uuidv4();
            const requestPayload = isHandoffMode
                ? {
                    route: 'handoff',
                    handoff: true,
                    handoff_timeout_sec: handoffTimeout,
                    handoff_reason: handoffReason,
                    chatInput: cleanedText,
                    text: cleanedText
                }
                : {
                    chatInput: cleanedText,
                    text: cleanedText,
                    inputType: 'text',
                    attachments: [],
                    history: history.slice(0, -1)
                };

            if (sessionToken) {
                if (isHandoffMode) {
                    requestPayload.session_id = sessionToken;
                } else {
                    requestPayload.sessionId = sessionToken;
                }
            }

            const requestMeta = {
                visitorId: visitorId,
                ownerId: metaOwnerOverride || visitorId,
                scope: metaScopeOverride || 'web',
                entityId: metaEntityOverride || (window.location.hostname || ''),
                requestId: requestId,
                pageUrl: window.location.href
            };

            if (sessionToken) {
                requestMeta.sessionId = sessionToken;
            }

            const payload = {
                proxy_id: chatConfig.proxy_id,
                config_key: chatConfig.config_key,
                payload: requestPayload,
                meta: requestMeta
            };

            if (csrfToken) {
                payload.csrf_token = csrfToken;
            }

            const response = await fetch(chatConfig.proxy_url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'same-origin',
                body: JSON.stringify(payload)
            });

            let data = null;
            try {
                data = await response.json();
            } catch (parseError) {
                data = null;
            }

            if (data && typeof data === 'object' && data !== null && data.csrf_token) {
                csrfToken = data.csrf_token;
                delete data.csrf_token;
            }

            if (!response.ok || !data) {
                const errorMessage = data && data.error ? data.error : 'Terjadi kesalahan saat menghubungi server.';
                if (data && data.proxy_id) {
                    chatConfig.proxy_id = data.proxy_id;
                }
                if (typingIndicator && typingIndicator.parentNode) {
                    typingIndicator.remove();
                }
                addMessage('bot', 'Error: ' + errorMessage);
                return;
            }

            const botResponse = extractBotMessage(data);
            const finalText = (typeof botResponse === 'string' ? botResponse : '')
                .trim() || 'Maaf, saya tidak dapat memproses permintaan tersebut.';

            if (typingIndicator && typingIndicator.parentNode) {
                const delay = typingDelayForText(finalText);
            if (delay > 0) {
                await new Promise((resolve) => setTimeout(resolve, delay));
            }
            typingIndicator.remove();
        }

        syncHandoffStateFromResponse(data);
        syncTransportFromResponse(data);

        addMessage('bot', finalText);
        history.push({ sender: 'bot', text: finalText });
        saveHistory();
        } catch (error) {
            if (typingIndicator && typingIndicator.parentNode) {
                typingIndicator.remove();
            }
            addMessage('bot', 'Failed to connect to the chatbot service.');
        } finally {
            input.disabled = false;
            sendButton.disabled = false;
            setSendLoading(false);
            input.focus();
        }
    }

    async function sendHandoffRequest() {
        if (!handoffEnabled || !chatConfig.proxy_url || handoffInFlight) {
            return;
        }

        handoffInFlight = true;
        setHandoffActive(true);
        if (handoffButton) {
            handoffButton.disabled = true;
        }

        if (handoffNotice) {
            addMessage('bot', handoffNotice);
            history.push({ sender: 'bot', text: handoffNotice });
            saveHistory();
        }

        try {
            const requestId = uuidv4();
            const handoffMessage = handoffLabel
                ? 'User meminta ' + handoffLabel
                : 'User meminta chat dengan admin.';
            const requestPayload = {
                route: 'handoff',
                handoff: true,
                handoff_timeout_sec: handoffTimeout,
                handoff_reason: handoffReason,
                chatInput: handoffMessage,
                text: handoffMessage
            };

            if (sessionToken) {
                requestPayload.session_id = sessionToken;
            }

            const requestMeta = {
                visitorId: visitorId,
                ownerId: metaOwnerOverride || visitorId,
                scope: metaScopeOverride || 'web',
                entityId: metaEntityOverride || (window.location.hostname || ''),
                requestId: requestId,
                pageUrl: window.location.href
            };

            if (sessionToken) {
                requestMeta.sessionId = sessionToken;
            }

            const payload = {
                proxy_id: chatConfig.proxy_id,
                config_key: chatConfig.config_key,
                payload: requestPayload,
                meta: requestMeta
            };

            if (csrfToken) {
                payload.csrf_token = csrfToken;
            }

            const response = await fetch(chatConfig.proxy_url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'same-origin',
                body: JSON.stringify(payload)
            });

            let data = null;
            try {
                data = await response.json();
            } catch (parseError) {
                data = null;
            }

            if (data && typeof data === 'object' && data !== null && data.csrf_token) {
                csrfToken = data.csrf_token;
                delete data.csrf_token;
            }

            if (!response.ok || !data) {
                const errorMessage = data && data.error ? data.error : 'Terjadi kesalahan saat menghubungi server.';
                addMessage('bot', 'Error: ' + errorMessage);
            } else {
                syncHandoffStateFromResponse(data);
                syncTransportFromResponse(data);
                const handoffResponse = extractBotMessage(data);
                if (handoffResponse) {
                    addMessage('bot', handoffResponse);
                    history.push({ sender: 'bot', text: handoffResponse });
                    saveHistory();
                }
            }
        } catch (error) {
            addMessage('bot', 'Failed to connect to the chatbot service.');
        } finally {
            handoffInFlight = false;
            if (handoffButton) {
                handoffButton.disabled = false;
            }
        }
    }

    async function sendHandoffOff() {
        if (!handoffEnabled || !chatConfig.proxy_url || !sessionToken) {
            return;
        }
        try {
            const requestId = uuidv4();
            const requestPayload = {
                route: 'handoff_off',
                session_id: sessionToken,
                text: 'Sesi handoff diakhiri oleh user.'
            };

            const requestMeta = {
                visitorId: visitorId,
                ownerId: metaOwnerOverride || visitorId,
                scope: metaScopeOverride || 'web',
                entityId: metaEntityOverride || (window.location.hostname || ''),
                requestId: requestId,
                pageUrl: window.location.href
            };

            const payload = {
                proxy_id: chatConfig.proxy_id,
                config_key: chatConfig.config_key,
                payload: requestPayload,
                meta: requestMeta
            };

            if (csrfToken) {
                payload.csrf_token = csrfToken;
            }

            const response = await fetch(chatConfig.proxy_url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'same-origin',
                body: JSON.stringify(payload)
            });

            let data = null;
            try {
                data = await response.json();
            } catch (parseError) {
                data = null;
            }

            if (data && typeof data === 'object' && data !== null && data.csrf_token) {
                csrfToken = data.csrf_token;
            }
        } catch (error) {
            // ignore handoff_off failures
        }
    }

    async function bootstrapChat() {
        try {
            const response = await fetch(bootstrapUrl, {
                method: 'POST',
                credentials: 'same-origin'
            });

            if (!response.ok) {
                throw new Error('Bootstrap request failed with status ' + response.status);
            }

            const bootstrapData = await response.json();
            if (!bootstrapData || !bootstrapData.success) {
                throw new Error(bootstrapData && bootstrapData.error ? bootstrapData.error : 'Bootstrap failed');
            }

            chatConfig = bootstrapData;
            csrfToken = bootstrapData.csrf_token || null;
            input.disabled = false;
            sendButton.disabled = false;
            root.classList.add('ai-chatbot-root--ready');
            ensureInputContrast();
        } catch (error) {
            console.error('AI Chatbot bootstrap failed:', error);
            root.style.display = 'none';
        }
    }

    chatButton.addEventListener('click', toggleChat);
    closeButton.addEventListener('click', closeChat);
    if (handoffButton) {
        handoffButton.addEventListener('click', (event) => {
            event.preventDefault();
            if (handoffActive) {
                setHandoffActive(false);
                sendHandoffOff();
                return;
            }
            sendHandoffRequest();
        });
    }
    if (scrollButton) {
        scrollButton.addEventListener('click', (event) => {
            event.preventDefault();
            scrollToBottom();
        });
    }
    if (messagesContainer) {
        messagesContainer.addEventListener('scroll', updateScrollButton);
        messagesContainer.addEventListener('click', (event) => {
            const target = event.target;
            if (!target) {
                return;
            }
            const button = target.closest('.chatbot-copy-btn');
            if (!button) {
                return;
            }
            event.preventDefault();
            const messageEl = button.closest('.chatbot-message');
            const text = getMessagePlainText(messageEl);
            if (!text) {
                return;
            }
            copyToClipboard(text).then(() => {
                button.setAttribute('title', 'Copied');
                setTimeout(() => {
                    button.setAttribute('title', 'Copy');
                }, 1200);
            }).catch(() => {
                // ignore copy failures
            });
        });
    }
    form.addEventListener('submit', (event) => {
        event.preventDefault();
        sendMessage();
    });
    input.addEventListener('keydown', (event) => {
        if (event.key === 'Enter' && !event.shiftKey) {
            event.preventDefault();
            sendMessage();
        }
    });
    input.addEventListener('focus', () => {
        ensureInputContrast();
    });
    input.addEventListener('input', () => {
        ensureInputContrast();
    });
    if (avatarImg && avatarImg.tagName === 'IMG') {
        avatarImg.addEventListener('click', (event) => {
            event.preventDefault();
            openImageViewer(avatarImg.src);
        });
    }
    if (imageViewer) {
        imageViewer.addEventListener('click', (event) => {
            if (event.target === imageViewer) {
                closeImageViewer();
            }
        });
    }
    if (imageViewerClose) {
        imageViewerClose.addEventListener('click', (event) => {
            event.preventDefault();
            closeImageViewer();
        });
    }
    document.addEventListener('click', handleDocumentClick);
    document.addEventListener('keydown', handleKeydown);
    window.addEventListener('resize', updateAutoHeight);
    if (window.matchMedia) {
        const colorSchemeQuery = window.matchMedia('(prefers-color-scheme: dark)');
        if (colorSchemeQuery && typeof colorSchemeQuery.addEventListener === 'function') {
            colorSchemeQuery.addEventListener('change', ensureInputContrast);
        } else if (colorSchemeQuery && typeof colorSchemeQuery.addListener === 'function') {
            colorSchemeQuery.addListener(ensureInputContrast);
        }
    }

    window.addEventListener('unload', () => {
        document.removeEventListener('click', handleDocumentClick);
        document.removeEventListener('keydown', handleKeydown);
        window.removeEventListener('resize', updateAutoHeight);
    });

    loadHistory();
    restoreHandoffState();
    bootstrapChat();
});
</script>
