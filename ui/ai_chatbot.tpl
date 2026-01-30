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

<style>
    :root {
        --chatbot-primary: #007bff;
        --chatbot-light: #f8f9fa;
        --chatbot-dark: #343a40;
        --chatbot-white: #ffffff;
        --chatbot-radius: 12px;
        --chatbot-shadow: 0 18px 48px rgba(15, 23, 42, 0.25);
        --chatbot-side-spacing: 24px;
        --chatbot-z-index: 1050;
    }

    .ai-chatbot-root {
        position: fixed;
        bottom: var(--chatbot-side-spacing);
        display: flex;
        align-items: flex-end;
        gap: 16px;
        z-index: var(--chatbot-z-index);
    }

    .ai-chatbot-root[data-enabled="0"] {
        display: none;
    }

    .ai-chatbot-root--right {
        right: var(--chatbot-side-spacing);
        flex-direction: row-reverse;
    }

    .ai-chatbot-root--left {
        left: var(--chatbot-side-spacing);
        flex-direction: row;
    }

    .ai-chatbot-button {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        background-color: var(--chatbot-primary);
        color: var(--chatbot-white);
        border: none;
        border-radius: 999px;
        padding: 0 24px;
        height: 48px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        box-shadow: 0 12px 24px rgba(0, 123, 255, 0.35);
        transition: transform 0.25s ease, box-shadow 0.25s ease, background-color 0.25s ease;
    }

    .ai-chatbot-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 16px 32px rgba(0, 123, 255, 0.45);
    }

    .ai-chatbot-button:focus-visible {
        outline: 3px solid rgba(0, 123, 255, 0.35);
        outline-offset: 3px;
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
        width: min(100vw - 40px, {$frame_width}px);
        height: min(80vh, {$frame_height}px);
        background: var(--chatbot-white);
        border-radius: var(--chatbot-radius);
        box-shadow: var(--chatbot-shadow);
        overflow: hidden;
    }

    .ai-chatbot-frame[data-frame-mode="auto"] {
        height: auto;
        max-height: 80vh;
    }

    .ai-chatbot-frame.is-open {
        display: flex;
    }

    .chatbot-header {
        background: var(--chatbot-primary);
        color: var(--chatbot-white);
        padding: 14px 18px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
    }

    .chatbot-header__title {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        font-weight: 600;
        font-size: 16px;
    }

    .chatbot-header__avatar {
        width: 34px;
        height: 34px;
        border-radius: 50%;
        object-fit: cover;
        background: rgba(255, 255, 255, 0.5);
    }

    .chatbot-close {
        background: rgba(255, 255, 255, 0.15);
        border: none;
        color: var(--chatbot-white);
        width: 34px;
        height: 34px;
        border-radius: 50%;
        font-size: 20px;
        line-height: 1;
        cursor: pointer;
        display: inline-flex;
        justify-content: center;
        align-items: center;
        transition: background-color 0.25s ease;
    }

    .chatbot-close:hover {
        background: rgba(255, 255, 255, 0.3);
    }

    .chatbot-close:focus-visible {
        outline: 2px solid rgba(255, 255, 255, 0.6);
        outline-offset: 2px;
    }

    .chatbot-messages {
        flex: 1;
        padding: 18px;
        overflow-y: auto;
        background: var(--chatbot-light);
        display: flex;
        flex-direction: column;
        gap: 12px;
        scroll-behavior: smooth;
    }

    .chatbot-message {
        display: flex;
        max-width: 85%;
    }

    .chatbot-message.user {
        margin-left: auto;
        flex-direction: row-reverse;
    }

    .chatbot-message-content {
        padding: 10px 14px;
        border-radius: 14px;
        box-shadow: 0 8px 16px rgba(15, 23, 42, 0.1);
        background: var(--chatbot-white);
        color: var(--chatbot-dark);
        line-height: 1.45;
        word-break: break-word;
    }

    .chatbot-message.user .chatbot-message-content {
        background: var(--chatbot-primary);
        color: var(--chatbot-white);
    }

    .chatbot-message.typing .chatbot-message-content {
        display: inline-flex;
        gap: 6px;
    }

    .typing-indicator span {
        height: 8px;
        width: 8px;
        background-color: rgba(15, 23, 42, 0.3);
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

    .chatbot-input-area {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 14px 16px;
        border-top: 1px solid #e5e7eb;
        background: var(--chatbot-white);
    }

    .chatbot-input-area input[type="text"] {
        flex: 1;
        border: 1px solid #d1d5db;
        border-radius: 12px;
        padding: 10px 14px;
        font-size: 15px;
        outline: none;
        transition: border-color 0.2s ease, box-shadow 0.2s ease;
    }

    .chatbot-input-area input[type="text"]:focus {
        border-color: var(--chatbot-primary);
        box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.15);
    }

    .chatbot-input-area button {
        background: var(--chatbot-primary);
        color: var(--chatbot-white);
        border: none;
        border-radius: 12px;
        padding: 10px 20px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.2s ease, transform 0.2s ease;
    }

    .chatbot-input-area button:hover:not([disabled]) {
        background: #0056d6;
        transform: translateY(-1px);
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

    @media (max-width: 720px) {
        .ai-chatbot-root {
            left: min(var(--chatbot-side-spacing), 20px);
            right: min(var(--chatbot-side-spacing), 20px);
            flex-direction: column;
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
            <div class="chatbot-header__title">
                {if $chatbot.chatbot_avatar_url|trim ne ''}
                    <img src="{$chatbot.chatbot_avatar_url|escape}" alt="" class="chatbot-header__avatar" />
                {/if}
                <span>{$chatbot_title|escape}</span>
            </div>
            <button type="button" class="chatbot-close" aria-label="Close chat">&times;</button>
        </div>
        <div class="chatbot-messages" role="log" aria-live="polite"></div>
        <form class="chatbot-input-area" autocomplete="off">
            <label class="chatbot-input__label" for="chatbot-input">Type your message</label>
            <input type="text" id="chatbot-input" name="chatbot-input" placeholder="Type a message..." maxlength="{$chatbot.chatbot_user_input_max_chars|default:1000|intval}" autocomplete="off" />
            <button type="submit" id="chatbot-send">Send</button>
        </form>
    </div>
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
    const messagesContainer = chatFrame ? chatFrame.querySelector('.chatbot-messages') : null;
    const form = chatFrame ? chatFrame.querySelector('.chatbot-input-area') : null;
    const input = document.getElementById('chatbot-input');
    const sendButton = document.getElementById('chatbot-send');

    if (!chatButton || !chatFrame || !closeButton || !messagesContainer || !form || !input || !sendButton) {
        console.error('AI Chatbot: required markup is missing.');
        root.style.display = 'none';
        return;
    }

    input.disabled = true;
    sendButton.disabled = true;

    const bootstrapUrl = "{$app_url|escape:'javascript'}?_route=plugin/ai_chatbot_settings/bootstrap";
    let chatConfig = {};
    let history = [];
    let csrfToken = null;

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

    if (chatFrame) {
        chatFrame.dataset.frameMode = frameMode;
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
            contentDiv.textContent = text || '';
        }

        messageDiv.appendChild(contentDiv);
        messagesContainer.appendChild(messageDiv);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
        updateAutoHeight();
        return messageDiv;
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
        if (!root.contains(event.target)) {
            setChatOpen(false);
        }
    }

    function handleKeydown(event) {
        if (event.key === 'Escape' && chatFrame.classList.contains('is-open')) {
            setChatOpen(false);
        }
    }

    function extractBotMessage(payload) {
        if (payload === null || payload === undefined) {
            return '';
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
                    const candidate = extractBotMessage(choice);
                    if (candidate) {
                        return candidate;
                    }
                }
            }

            if (payload.data !== undefined) {
                const candidate = extractBotMessage(payload.data);
                if (candidate) {
                    return candidate;
                }
            }

            const numericKeys = Object.keys(payload)
                .filter((key) => /^[0-9]+$/.test(key))
                .sort((a, b) => parseInt(a, 10) - parseInt(b, 10));

            for (const key of numericKeys) {
                const candidate = extractBotMessage(payload[key]);
                if (candidate) {
                    return candidate;
                }
            }
        }

        return '';
    }

    async function sendMessage() {
        const text = input.value.trim();
        if (text === '' || !chatConfig.proxy_url) {
            return;
        }

        addMessage('user', text);
        history.push({ sender: 'user', text });
        saveHistory();

        input.value = '';
        input.disabled = true;
        sendButton.disabled = true;

        const typingIndicator = typingMode === 'wpm' ? addMessage('bot', '', true) : null;

        try {
            const requestPayload = {
                chatInput: text,
                history: history.slice(0, -1)
            };

            if (sessionToken) {
                requestPayload.sessionId = sessionToken;
            }

            const requestMeta = {
                visitorId: visitorId,
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
            input.focus();
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
        } catch (error) {
            console.error('AI Chatbot bootstrap failed:', error);
            root.style.display = 'none';
        }
    }

    chatButton.addEventListener('click', toggleChat);
    closeButton.addEventListener('click', closeChat);
    form.addEventListener('submit', (event) => {
        event.preventDefault();
        sendMessage();
    });
    document.addEventListener('click', handleDocumentClick);
    document.addEventListener('keydown', handleKeydown);
    window.addEventListener('resize', updateAutoHeight);

    window.addEventListener('unload', () => {
        document.removeEventListener('click', handleDocumentClick);
        document.removeEventListener('keydown', handleKeydown);
        window.removeEventListener('resize', updateAutoHeight);
    });

    loadHistory();
    bootstrapChat();
});
</script>
