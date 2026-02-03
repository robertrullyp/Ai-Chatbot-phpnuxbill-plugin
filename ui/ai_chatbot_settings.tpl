{include file="admin/header.tpl"}

{assign var=is_enabled value=($config.chatbot_enabled eq '1')}

{literal}
<style>
    .chatbot-panel {
        --chatbot-accent: #2563eb;
        --chatbot-accent-soft: rgba(37, 99, 235, 0.12);
        --chatbot-surface: #ffffff;
        --chatbot-surface-muted: #f8fafc;
        --chatbot-border: rgba(148, 163, 184, 0.35);
        --chatbot-border-strong: rgba(148, 163, 184, 0.6);
        --chatbot-text: #0f172a;
        --chatbot-muted: #64748b;
        --chatbot-shadow: 0 16px 34px rgba(15, 23, 42, 0.08);
    }
    .dark-mode .chatbot-panel {
        --chatbot-accent: #3b82f6;
        --chatbot-accent-soft: rgba(59, 130, 246, 0.2);
        --chatbot-surface: #0f172a;
        --chatbot-surface-muted: #0b1526;
        --chatbot-border: rgba(148, 163, 184, 0.2);
        --chatbot-border-strong: rgba(148, 163, 184, 0.35);
        --chatbot-text: #e2e8f0;
        --chatbot-muted: #94a3b8;
        --chatbot-shadow: 0 20px 44px rgba(2, 6, 23, 0.55);
    }

    .chatbot-settings-wrapper { position: relative; }
    .chatbot-summary {
        background: linear-gradient(135deg, var(--chatbot-accent-soft) 0%, #ffffff 60%);
        border: 1px solid var(--chatbot-border);
        border-radius: 16px;
        padding: 22px 26px;
        margin-bottom: 24px;
        box-shadow: 0 10px 24px rgba(15, 23, 42, 0.06);
        animation: chatbot-rise 220ms ease-out both;
    }
    .dark-mode .chatbot-summary {
        background: linear-gradient(140deg, rgba(59, 130, 246, 0.18) 0%, rgba(15, 23, 42, 0.95) 60%);
        box-shadow: 0 14px 32px rgba(2, 6, 23, 0.55);
    }
    .chatbot-summary__top { display: flex; flex-wrap: wrap; justify-content: space-between; gap: 16px; align-items: center; }
    .chatbot-summary__label {
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 0.12em;
        color: var(--chatbot-muted);
        display: block;
        margin-bottom: 6px;
        font-weight: 700;
    }
    .chatbot-summary__label--spaced { margin-top: 12px; }
    .chatbot-summary__endpoint code {
        display: inline-block;
        padding: 6px 10px;
        border-radius: 10px;
        background: rgba(15, 23, 42, 0.06);
        color: var(--chatbot-text);
        word-break: break-all;
    }
    .dark-mode .chatbot-summary__endpoint code {
        background: rgba(2, 6, 23, 0.5);
        border: 1px solid var(--chatbot-border);
        color: var(--chatbot-text);
    }
    .chatbot-summary__description { margin: 12px 0 0; color: #475569; font-size: 13px; line-height: 1.6; max-width: 720px; }
    .dark-mode .chatbot-summary__description { color: #cbd5f5; }
    .chatbot-status {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 4px 12px;
        border-radius: 999px;
        font-weight: 600;
        font-size: 12px;
    }
    .chatbot-status::before { content: ""; width: 7px; height: 7px; border-radius: 999px; background: currentColor; display: inline-block; }
    .chatbot-status--on { background: rgba(16, 185, 129, 0.12); color: #0f766e; }
    .chatbot-status--off { background: rgba(244, 63, 94, 0.12); color: #be123c; }
    .dark-mode .chatbot-status {
        border: 1px solid transparent;
        text-shadow: 0 1px 1px rgba(15, 23, 42, 0.35);
    }
    .dark-mode .chatbot-status--on {
        background: rgba(16, 185, 129, 0.35);
        color: #ecfdf5;
        border-color: rgba(16, 185, 129, 0.55);
    }
    .dark-mode .chatbot-status--off {
        background: rgba(248, 113, 113, 0.35);
        color: #fff1f2;
        border-color: rgba(248, 113, 113, 0.55);
    }

    .chatbot-tabs {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        border: 1px solid var(--chatbot-border);
        border-radius: 12px;
        padding: 6px;
        background: var(--chatbot-surface-muted);
        margin-bottom: 18px;
    }
    .dark-mode .chatbot-tabs { background: #0b1626; }
    .chatbot-tabs > li { float: none; margin: 0; }
    .chatbot-tabs .nav-link,
    .chatbot-tabs > li > a {
        border-radius: 10px;
        padding: 8px 14px;
        border: 1px solid transparent;
        color: var(--chatbot-muted);
        font-weight: 600;
        transition: background 160ms ease, border-color 160ms ease, color 160ms ease, box-shadow 160ms ease;
    }
    .dark-mode .chatbot-tabs .nav-link,
    .dark-mode .chatbot-tabs > li > a { color: #a8b4c7; }
    .chatbot-tabs .nav-link:hover,
    .chatbot-tabs > li > a:hover {
        color: var(--chatbot-text);
        background: #ffffff;
        border-color: var(--chatbot-border);
    }
    .dark-mode .chatbot-tabs .nav-link:hover,
    .dark-mode .chatbot-tabs > li > a:hover {
        background: rgba(148, 163, 184, 0.12);
        color: var(--chatbot-text);
        border-color: var(--chatbot-border);
    }
    .chatbot-tabs .nav-link.active,
    .chatbot-tabs > li.active > a {
        color: #ffffff;
        background: var(--chatbot-accent);
        border-color: var(--chatbot-accent);
        box-shadow: 0 12px 24px rgba(37, 99, 235, 0.25);
    }

    .chatbot-card {
        background: var(--chatbot-surface);
        border-radius: 14px;
        border: 1px solid var(--chatbot-border);
        padding: 20px 24px;
        margin-bottom: 24px;
        box-shadow: 0 10px 26px rgba(15, 23, 42, 0.05);
        transition: transform 200ms ease, box-shadow 200ms ease, border-color 200ms ease;
        animation: chatbot-rise 220ms ease-out both;
    }
    .dark-mode .chatbot-card {
        box-shadow: 0 12px 30px rgba(2, 6, 23, 0.55);
        border-color: var(--chatbot-border);
    }
    .chatbot-card:hover { transform: translateY(-2px); box-shadow: var(--chatbot-shadow); border-color: rgba(37, 99, 235, 0.3); }
    .chatbot-card__title { font-size: 16px; font-weight: 700; color: #111827; margin-bottom: 6px; }
    .chatbot-card__subtitle { font-size: 13px; color: #6b7280; margin-bottom: 16px; }
    .dark-mode .chatbot-card__title { color: var(--chatbot-text); }
    .dark-mode .chatbot-card__subtitle { color: var(--chatbot-muted); }

    .chatbot-card .form-group { margin-bottom: 16px; }
    .chatbot-card .form-group:last-child { margin-bottom: 0; }
    .chatbot-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 18px 22px; align-items: start; }
    .chatbot-grid .form-group { margin: 0; }
    .chatbot-grid textarea.form-control { min-height: 120px; resize: vertical; }
    .chatbot-card label { font-weight: 600; color: #0f172a; }
    .chatbot-helper { font-size: 12px; color: var(--chatbot-muted); margin-top: 6px; display: block; line-height: 1.5; }
    .chatbot-multi { min-height: 220px; }
    .dark-mode .chatbot-card label { color: var(--chatbot-text); }

    .chatbot-auth-block {
        display: none;
        border: 1px dashed var(--chatbot-border-strong);
        background: var(--chatbot-surface-muted);
        border-radius: 12px;
        padding: 16px;
        margin-top: 18px;
    }
    .chatbot-auth-divider {
        height: 1px;
        background: var(--chatbot-border);
        margin: 18px 0;
        border: 0;
    }
    .dark-mode .chatbot-auth-block { background: rgba(2, 6, 23, 0.45); }
    .chatbot-auth-block.is-active {
        display: block;
        animation: chatbot-fade-in 180ms ease-out both;
    }
    .chatbot-admin-block { display: none; }
    .chatbot-admin-block.is-active { display: block; animation: chatbot-fade-in 180ms ease-out both; }
    .chatbot-auth-title { font-size: 12px; font-weight: 700; color: var(--chatbot-muted); letter-spacing: 0.08em; text-transform: uppercase; margin-bottom: 12px; }

    .chatbot-form-actions {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 18px;
        padding-top: 16px;
        border-top: 1px solid var(--chatbot-border);
        gap: 12px;
        flex-wrap: wrap;
    }
    .chatbot-form-actions .btn { border-radius: 10px; padding: 10px 18px; min-width: 160px; }
    .chatbot-form-note { font-size: 12px; color: var(--chatbot-muted); }
    .chatbot-form-note a { color: var(--chatbot-accent); text-decoration: none; font-weight: 600; }
    .chatbot-form-note a:hover { text-decoration: underline; }

    .chatbot-panel .form-control {
        border-radius: 10px;
        border-color: var(--chatbot-border);
        box-shadow: none;
        transition: border-color 160ms ease, box-shadow 160ms ease;
    }
    .dark-mode .chatbot-panel .form-control {
        background-color: rgba(15, 23, 42, 0.6);
        color: var(--chatbot-text);
        border-color: var(--chatbot-border);
    }
    .dark-mode .chatbot-panel .form-control::placeholder { color: #8fa1b6; }
    .chatbot-panel .form-control:focus {
        border-color: rgba(37, 99, 235, 0.6);
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
    }
    .chatbot-panel .mt-4 { margin-top: 20px; }

    .chatbot-field-row {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .chatbot-field-row .form-control { flex: 1 1 auto; }
    .chatbot-field-row--with-advanced .chatbot-advanced-field { display: none; flex: 1 1 auto; }
    .chatbot-field-row--with-advanced.is-advanced .chatbot-advanced-field { display: block; }
    .chatbot-field-row--with-advanced .chatbot-field-controls {
        display: flex;
        align-items: center;
        gap: 10px;
        flex: 1 1 auto;
    }
    .chatbot-field-row--with-advanced.is-advanced .chatbot-field-controls { flex: 0 0 auto; }
    .chatbot-color-input {
        width: 44px;
        height: 38px;
        padding: 0;
        border-radius: 8px;
        cursor: pointer;
    }
    .chatbot-select-compact { max-width: 180px; }
    .chatbot-custom-settings.is-hidden { display: none; }
    .chatbot-theme-hint { margin-bottom: 16px; }

    @keyframes chatbot-rise {
        from { opacity: 0; transform: translateY(8px); }
        to { opacity: 1; transform: translateY(0); }
    }
    @keyframes chatbot-fade-in {
        from { opacity: 0; transform: translateY(6px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 640px) {
        .chatbot-summary { padding: 16px; }
        .chatbot-card { padding: 16px; }
        .chatbot-grid { gap: 12px; }
        .chatbot-tabs { padding: 4px; }
        .chatbot-form-actions { justify-content: center; }
    }

    @media (prefers-reduced-motion: reduce) {
        .chatbot-summary,
        .chatbot-card,
        .chatbot-auth-block.is-active { animation: none; }
        .chatbot-card,
        .chatbot-tabs .nav-link,
        .chatbot-tabs > li > a,
        .chatbot-panel .form-control { transition: none; }
    }
</style>
{/literal}

<div class="row">
    <div class="col-md-12">
        <div class="panel chatbot-panel">
            <div class="panel-hdr">
                <h2>AI Chatbot Settings</h2>
            </div>
            <div class="panel-container">
                <div class="panel-content chatbot-settings-wrapper">

                    <div class="chatbot-summary">
                        <div class="chatbot-summary__top">
                            <div>
                                <span class="chatbot-summary__label">Status</span>
                                <span class="chatbot-status {if $is_enabled}chatbot-status--on{else}chatbot-status--off{/if}">
                                    {if $is_enabled}Active{else}Disabled{/if}
                                </span>
                            </div>
                            <div class="chatbot-summary__endpoint">
                                <span class="chatbot-summary__label">Endpoint Publik/Customer</span>
                                {if $config.chatbot_endpoint|trim neq ''}
                                    <code>{$config.chatbot_endpoint|escape}</code>
                                {else}
                                    <span class="text-muted">Not configured</span>
                                {/if}
                                <span class="chatbot-summary__label chatbot-summary__label--spaced">Endpoint Admin</span>
                                {if $config.chatbot_admin_endpoint_enabled == '1'}
                                    {if $config.chatbot_endpoint_admin|trim neq ''}
                                        <code>{$config.chatbot_endpoint_admin|escape}</code>
                                    {else}
                                        <span class="text-muted">Belum diisi</span>
                                    {/if}
                                {else}
                                    <span class="text-muted">Disabled</span>
                                {/if}
                            </div>
                        </div>
                        <p class="chatbot-summary__description">

                        </p>
                    </div>

                    <ul class="nav nav-tabs chatbot-tabs" role="tablist">
                        {foreach $chatbot_sections as $key => $anchor}
                            {if $key eq 'styling'}
                                {assign var=tab_label value='Theme'}
                            {else}
                                {assign var=tab_label value=$key|replace:'-':' '|ucwords}
                            {/if}
                            <li class="nav-item {if $key eq $chatbot_active_section}active{/if}"><a class="nav-link {if $key eq $chatbot_active_section}active{/if}" href="{getUrl('plugin/ai_chatbot_settings/')}{$key}">{$tab_label}</a></li>
                        {/foreach}
                    </ul>

                    <form method="post" action="{getUrl('plugin/ai_chatbot_settings/')}{$chatbot_active_section}" class="mt-4">
                        {if isset($csrf_token)}
                            <input type="hidden" name="csrf_token" value="{$csrf_token}">
                        {/if}
                        <div class="tab-content">
                            <div class="tab-pane active" id="{$chatbot_active_anchor}">

                                {if $chatbot_active_section eq 'general'}
                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Aktivasi & Endpoint</h3>
                                        <p class="chatbot-card__subtitle">Tentukan apakah chatbot aktif serta ke mana permintaan dikirim.</p>
                                        <div class="chatbot-grid">
                                            <div class="form-group">
                                                <label for="chatbot_enabled">Enable Chatbot</label>
                                                <select id="chatbot_enabled" name="chatbot_enabled" class="form-control">
                                                    <option value="1" {if $config.chatbot_enabled == '1'}selected{/if}>Yes</option>
                                                    <option value="0" {if $config.chatbot_enabled == '0'}selected{/if}>No</option>
                                                </select>
                                                <span class="chatbot-helper">Nonaktifkan jika Anda ingin menyembunyikan tombol chatbot di seluruh halaman.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_endpoint">Endpoint Publik/Customer</label>
                                                <input type="url" id="chatbot_endpoint" name="chatbot_endpoint" class="form-control" value="{$config.chatbot_endpoint|escape}" placeholder="https://your.ai.endpoint/chat">
                                                <span class="chatbot-helper">Dipakai untuk halaman publik & customer. Endpoint admin dapat menggantikannya.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_admin_endpoint_enabled">Enable Endpoint Admin</label>
                                                <select id="chatbot_admin_endpoint_enabled" name="chatbot_admin_endpoint_enabled" class="form-control">
                                                    <option value="1" {if $config.chatbot_admin_endpoint_enabled == '1'}selected{/if}>Yes</option>
                                                    <option value="0" {if $config.chatbot_admin_endpoint_enabled == '0'}selected{/if}>No</option>
                                                </select>
                                                <span class="chatbot-helper">Jika aktif, admin akan memakai endpoint terpisah dengan autentikasi & payload khusus.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_endpoint_admin">Endpoint Admin (Opsional)</label>
                                                <input type="url" id="chatbot_endpoint_admin" name="chatbot_endpoint_admin" class="form-control" value="{$config.chatbot_endpoint_admin|escape}" placeholder="https://admin.ai.endpoint/chat">
                                                <span class="chatbot-helper">Isi jika ingin endpoint berbeda khusus saat admin membuka chatbot.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_request_timeout">Request Timeout (detik)</label>
                                                <input type="number" min="5" max="600" id="chatbot_request_timeout" name="chatbot_request_timeout" class="form-control" value="{$config.chatbot_request_timeout|escape}">
                                                <span class="chatbot-helper">Berapa lama sistem menunggu respons sebelum menampilkan pesan gagal.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_status_throttle">Status Check Throttle (detik)</label>
                                                <input type="number" min="0" max="600" id="chatbot_status_throttle" name="chatbot_status_throttle" class="form-control" value="{$config.chatbot_status_throttle|default:30|escape}">
                                                <span class="chatbot-helper">0 untuk cek status setiap kali panel dibuka, atau isi angka untuk menunda pengecekan ulang.</span>
                                            </div>
                                        </div>
                                        <div class="chatbot-auth-title" style="margin-top: 12px;">Metode Autentikasi (Publik/Customer)</div>
                                        <div class="chatbot-grid">
                                            <div class="form-group">
                                                <label for="chatbot_auth_type">Authentication Type</label>
                                                <select id="chatbot_auth_type" name="chatbot_auth_type" class="form-control">
                                                    <option value="none" {if $config.chatbot_auth_type == 'none'}selected{/if}>None</option>
                                                    <option value="header" {if $config.chatbot_auth_type == 'header'}selected{/if}>Custom Header</option>
                                                    <option value="basic" {if $config.chatbot_auth_type == 'basic'}selected{/if}>Basic Auth</option>
                                                    <option value="jwt" {if $config.chatbot_auth_type == 'jwt'}selected{/if}>JWT (HMAC)</option>
                                                </select>
                                                <span class="chatbot-helper">Gunakan <em>Custom Header</em> untuk API key sederhana, atau JWT untuk token dinamis.</span>
                                            </div>
                                        </div>

                                        <div class="chatbot-auth-block js-auth-block" data-auth-mode="header">
                                            <div class="chatbot-auth-title">Custom Header</div>
                                            <div class="chatbot-grid">
                                                <div class="form-group">
                                                    <label for="chatbot_header_key">Header Name</label>
                                                    <input type="text" id="chatbot_header_key" name="chatbot_header_key" class="form-control" value="{$config.chatbot_header_key|escape}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="chatbot_header_value">Header Value</label>
                                                    <input type="text" id="chatbot_header_value" name="chatbot_header_value" class="form-control" value="{$config.chatbot_header_value|escape}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="chatbot_as_bearer">Format Value</label>
                                                    <select id="chatbot_as_bearer" name="chatbot_as_bearer" class="form-control">
                                                        <option value="no" {if $config.chatbot_as_bearer == 'no'}selected{/if}>Gunakan apa adanya</option>
                                                        <option value="yes" {if $config.chatbot_as_bearer == 'yes'}selected{/if}>Prefix dengan Bearer</option>
                                                    </select>
                                                    <span class="chatbot-helper">Jika memilih Bearer, nilai akan dikirim sebagai <code>Authorization: Bearer &lt;value&gt;</code>.</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="chatbot-auth-block js-auth-block" data-auth-mode="basic">
                                            <div class="chatbot-auth-title">Basic Authentication</div>
                                            <div class="chatbot-grid">
                                                <div class="form-group">
                                                    <label for="chatbot_basic_user">Username</label>
                                                    <input type="text" id="chatbot_basic_user" name="chatbot_basic_user" class="form-control" value="{$config.chatbot_basic_user|escape}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="chatbot_basic_pass">Password</label>
                                                    <input type="password" id="chatbot_basic_pass" name="chatbot_basic_pass" class="form-control" value="{$config.chatbot_basic_pass|escape}">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="chatbot-auth-block js-auth-block" data-auth-mode="jwt">
                                            <div class="chatbot-auth-title">JWT (HS256)</div>
                                            <div class="chatbot-grid">
                                                <div class="form-group">
                                                    <label for="chatbot_jwt_token">Token ID / Subject</label>
                                                    <input type="text" id="chatbot_jwt_token" name="chatbot_jwt_token" class="form-control" value="{$config.chatbot_jwt_token|escape}" placeholder="token-id">
                                                </div>
                                                <div class="form-group">
                                                    <label for="chatbot_jwt_secret">Shared Secret</label>
                                                    <input type="password" id="chatbot_jwt_secret" name="chatbot_jwt_secret" class="form-control" value="{$config.chatbot_jwt_secret|escape}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="chatbot_jwt_iss">Issuer (iss)</label>
                                                    <input type="text" id="chatbot_jwt_iss" name="chatbot_jwt_iss" class="form-control" value="{$config.chatbot_jwt_iss|escape}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="chatbot_jwt_aud">Audience (aud)</label>
                                                    <input type="text" id="chatbot_jwt_aud" name="chatbot_jwt_aud" class="form-control" value="{$config.chatbot_jwt_aud|escape}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="chatbot_jwt_sub">Subject (sub)</label>
                                                    <input type="text" id="chatbot_jwt_sub" name="chatbot_jwt_sub" class="form-control" value="{$config.chatbot_jwt_sub|escape}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="chatbot_jwt_ttl">TTL (detik)</label>
                                                    <input type="number" min="60" max="3600" id="chatbot_jwt_ttl" name="chatbot_jwt_ttl" class="form-control" value="{$config.chatbot_jwt_ttl|escape}">
                                                </div>
                                            </div>
                                            <span class="chatbot-helper">Plugin akan menghasilkan token JWT HS256 baru setiap kali percakapan dikirim.</span>
                                        </div>

                                        <div class="chatbot-auth-divider"></div>
                                        <div class="chatbot-admin-block js-admin-endpoint-block">
                                            <div class="chatbot-auth-title">Metode Autentikasi (Admin)</div>
                                            <div class="chatbot-grid">
                                                <div class="form-group">
                                                    <label for="chatbot_admin_auth_type">Authentication Type</label>
                                                    <select id="chatbot_admin_auth_type" name="chatbot_admin_auth_type" class="form-control">
                                                        <option value="none" {if $config.chatbot_admin_auth_type == 'none'}selected{/if}>None</option>
                                                        <option value="header" {if $config.chatbot_admin_auth_type == 'header'}selected{/if}>Custom Header</option>
                                                        <option value="basic" {if $config.chatbot_admin_auth_type == 'basic'}selected{/if}>Basic Auth</option>
                                                        <option value="jwt" {if $config.chatbot_admin_auth_type == 'jwt'}selected{/if}>JWT (HMAC)</option>
                                                    </select>
                                                    <span class="chatbot-helper">Autentikasi khusus saat admin memakai endpoint admin.</span>
                                                </div>
                                            </div>

                                            <div class="chatbot-auth-block js-admin-auth-block" data-auth-mode="header">
                                                <div class="chatbot-auth-title">Custom Header</div>
                                                <div class="chatbot-grid">
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_header_key">Header Name</label>
                                                        <input type="text" id="chatbot_admin_header_key" name="chatbot_admin_header_key" class="form-control" value="{$config.chatbot_admin_header_key|escape}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_header_value">Header Value</label>
                                                        <input type="text" id="chatbot_admin_header_value" name="chatbot_admin_header_value" class="form-control" value="{$config.chatbot_admin_header_value|escape}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_as_bearer">Format Value</label>
                                                        <select id="chatbot_admin_as_bearer" name="chatbot_admin_as_bearer" class="form-control">
                                                            <option value="no" {if $config.chatbot_admin_as_bearer == 'no'}selected{/if}>Gunakan apa adanya</option>
                                                            <option value="yes" {if $config.chatbot_admin_as_bearer == 'yes'}selected{/if}>Prefix dengan Bearer</option>
                                                        </select>
                                                        <span class="chatbot-helper">Jika memilih Bearer, nilai akan dikirim sebagai <code>Authorization: Bearer &lt;value&gt;</code>.</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="chatbot-auth-block js-admin-auth-block" data-auth-mode="basic">
                                                <div class="chatbot-auth-title">Basic Authentication</div>
                                                <div class="chatbot-grid">
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_basic_user">Username</label>
                                                        <input type="text" id="chatbot_admin_basic_user" name="chatbot_admin_basic_user" class="form-control" value="{$config.chatbot_admin_basic_user|escape}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_basic_pass">Password</label>
                                                        <input type="password" id="chatbot_admin_basic_pass" name="chatbot_admin_basic_pass" class="form-control" value="{$config.chatbot_admin_basic_pass|escape}">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="chatbot-auth-block js-admin-auth-block" data-auth-mode="jwt">
                                                <div class="chatbot-auth-title">JWT (HS256)</div>
                                                <div class="chatbot-grid">
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_jwt_token">Token ID / Subject</label>
                                                        <input type="text" id="chatbot_admin_jwt_token" name="chatbot_admin_jwt_token" class="form-control" value="{$config.chatbot_admin_jwt_token|escape}" placeholder="token-id">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_jwt_secret">Shared Secret</label>
                                                        <input type="password" id="chatbot_admin_jwt_secret" name="chatbot_admin_jwt_secret" class="form-control" value="{$config.chatbot_admin_jwt_secret|escape}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_jwt_iss">Issuer (iss)</label>
                                                        <input type="text" id="chatbot_admin_jwt_iss" name="chatbot_admin_jwt_iss" class="form-control" value="{$config.chatbot_admin_jwt_iss|escape}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_jwt_aud">Audience (aud)</label>
                                                        <input type="text" id="chatbot_admin_jwt_aud" name="chatbot_admin_jwt_aud" class="form-control" value="{$config.chatbot_admin_jwt_aud|escape}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_jwt_sub">Subject (sub)</label>
                                                        <input type="text" id="chatbot_admin_jwt_sub" name="chatbot_admin_jwt_sub" class="form-control" value="{$config.chatbot_admin_jwt_sub|escape}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="chatbot_admin_jwt_ttl">TTL (detik)</label>
                                                        <input type="number" min="60" max="3600" id="chatbot_admin_jwt_ttl" name="chatbot_admin_jwt_ttl" class="form-control" value="{$config.chatbot_admin_jwt_ttl|escape}">
                                                    </div>
                                                </div>
                                                <span class="chatbot-helper">Token JWT HS256 untuk admin akan dibuat setiap request admin.</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Chat dengan Admin (Handoff)</h3>
                                        <p class="chatbot-card__subtitle">Kirim route handoff ke gateway agar admin bisa mengambil alih percakapan.</p>
                                        <div class="chatbot-grid">
                                            <div class="form-group">
                                                <label for="chatbot_handoff_enabled">Enable Chat dengan Admin</label>
                                                <select id="chatbot_handoff_enabled" name="chatbot_handoff_enabled" class="form-control">
                                                    <option value="1" {if $config.chatbot_handoff_enabled == '1'}selected{/if}>Yes</option>
                                                    <option value="0" {if $config.chatbot_handoff_enabled == '0'}selected{/if}>No</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_handoff_label">Button Label</label>
                                                <input type="text" id="chatbot_handoff_label" name="chatbot_handoff_label" class="form-control" value="{$config.chatbot_handoff_label|escape}" placeholder="Chat dengan Admin">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_handoff_timeout">Handoff Timeout (detik)</label>
                                                <input type="number" min="0" max="86400" id="chatbot_handoff_timeout" name="chatbot_handoff_timeout" class="form-control" value="{$config.chatbot_handoff_timeout|escape}">
                                                <span class="chatbot-helper">Nilai ini dikirim sebagai <code>handoff_timeout_sec</code>. 0 = tanpa timeout.</span>
                                            </div>
                                            <div class="form-group" style="grid-column: 1 / -1;">
                                                <label for="chatbot_handoff_notice">Notice Message</label>
                                                <textarea id="chatbot_handoff_notice" name="chatbot_handoff_notice" class="form-control" placeholder="Permintaan terkirim. Admin akan segera bergabung.">{$config.chatbot_handoff_notice|escape}</textarea>
                                                <span class="chatbot-helper">Pesan yang ditampilkan di chat setelah tombol ditekan.</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Penempatan Pada Footer Publik/Customer</h3>
                                        <p class="chatbot-card__subtitle">Pilih footer publik/customer yang akan memuat tombol chatbot.</p>
                                        {if $chatbot_footer_public_options|@count}
                                            <div class="form-group">
                                                <label for="chatbot_footer_targets">Halaman Publik/Customer</label>
                                                <select id="chatbot_footer_targets" name="chatbot_footer_targets[]" class="form-control chatbot-multi" multiple size="10">
                                                    {foreach $chatbot_footer_public_options as $option}
                                                        <option value="{$option.path|escape}" {if $option.selected}selected{/if}>
                                                            {$option.label|escape}{if isset($option.exists) && !$option.exists} (missing){/if}
                                                        </option>
                                                    {/foreach}
                                                </select>
                                                <span class="chatbot-helper">Gunakan Ctrl/Command + klik untuk memilih lebih dari satu. Beri kosong untuk menonaktifkan seluruh penempatan.</span>
                                            </div>
                                        {else}
                                            <div class="alert alert-warning mb-0">
                                                Tidak ditemukan template footer di <code>ui/ui</code> maupun <code>ui/ui_custom</code>. Tambahkan footer terlebih dahulu untuk menggunakan fitur ini.
                                            </div>
                                        {/if}
                                    </div>

                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Penempatan Pada Footer Admin</h3>
                                        <p class="chatbot-card__subtitle">Pilih footer admin yang akan memuat tombol chatbot di panel admin.</p>
                                        {if $chatbot_footer_admin_options|@count}
                                            <div class="form-group">
                                                <label for="chatbot_footer_targets_admin">Halaman Admin</label>
                                                <select id="chatbot_footer_targets_admin" name="chatbot_footer_targets_admin[]" class="form-control chatbot-multi" multiple size="8">
                                                    {foreach $chatbot_footer_admin_options as $option}
                                                        <option value="{$option.path|escape}" {if $option.selected}selected{/if}>
                                                            {$option.label|escape}{if isset($option.exists) && !$option.exists} (missing){/if}
                                                        </option>
                                                    {/foreach}
                                                </select>
                                                <span class="chatbot-helper">Kosongkan jika tidak ingin menampilkan chatbot di area admin.</span>
                                            </div>
                                        {else}
                                            <div class="alert alert-warning mb-0">
                                                Tidak ditemukan template footer admin di <code>ui/ui</code> maupun <code>ui/ui_custom</code>.
                                            </div>
                                        {/if}
                                    </div>
                                {/if}

                                {if $chatbot_active_section eq 'styling'}
                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Template Tema</h3>
                                        <p class="chatbot-card__subtitle">Pilih tema cepat untuk mengisi semua warna &amp; style. Anda masih bisa modifikasi dan akan otomatis menjadi Custom.</p>
                                        <div class="form-group mb-0">
                                            <label for="chatbot_theme_preset">Theme Preset</label>
                                            <select id="chatbot_theme_preset" name="chatbot_theme_preset" class="form-control">
                                                <option value="custom" {if $config.chatbot_theme_preset == 'custom' || $config.chatbot_theme_preset == ''}selected{/if}>Custom (Manual)</option>
                                                <option value="ocean" {if $config.chatbot_theme_preset == 'ocean'}selected{/if}>Ocean</option>
                                                <option value="dark_glass" {if $config.chatbot_theme_preset == 'dark_glass'}selected{/if}>Dark Glass</option>
                                                <option value="minimal" {if $config.chatbot_theme_preset == 'minimal'}selected{/if}>Minimal</option>
                                                <option value="neon" {if $config.chatbot_theme_preset == 'neon'}selected{/if}>Neon</option>
                                                <option value="forest" {if $config.chatbot_theme_preset == 'forest'}selected{/if}>Forest</option>
                                                <option value="modern" {if $config.chatbot_theme_preset == 'modern'}selected{/if}>Modern</option>
                                                <option value="aesthetic" {if $config.chatbot_theme_preset == 'aesthetic'}selected{/if}>Aesthetic</option>
                                                <option value="futuristic" {if $config.chatbot_theme_preset == 'futuristic'}selected{/if}>Futuristic</option>
                                            </select>
                                            <span class="chatbot-helper">Mengubah preset akan mengisi nilai di bawah. Ubah manual => preset menjadi Custom.</span>
                                        </div>
                                    </div>
                                    <div class="alert alert-info chatbot-theme-hint js-chatbot-theme-hint" style="display: none;">
                                        Preset tema aktif. Pilih <strong>Custom</strong> untuk menampilkan pengaturan styling lanjutan.
                                    </div>
                                    <div class="chatbot-custom-settings js-chatbot-custom-settings">
                                        <div class="chatbot-card">
                                            <h3 class="chatbot-card__title">Mode Pengaturan</h3>
                                            <p class="chatbot-card__subtitle">Gunakan preset cepat, atau tampilkan input CSS lanjutan jika perlu.</p>
                                            <div class="form-group mb-0">
                                                <label>
                                                    <input type="checkbox" id="chatbot_show_advanced_controls" />
                                                    Tampilkan input CSS lanjutan (teks)
                                                </label>
                                                <span class="chatbot-helper">Mode lanjutan memberi akses input manual untuk gradient/var CSS.</span>
                                            </div>
                                        </div>
                                {/if}

                                {if $chatbot_active_section eq 'chat-experience'}
                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Launcher & Tampilan</h3>
                                        <p class="chatbot-card__subtitle">Atur judul, label tombol, avatar, dan ukuran jendela chat.</p>
                                        <div class="chatbot-grid">
                                            <div class="form-group">
                                                <label for="chatbot_title">Chat Title</label>
                                                <input type="text" id="chatbot_title" name="chatbot_title" class="form-control" value="{$config.chatbot_title|escape}">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_button_label">Button Label</label>
                                                <input type="text" id="chatbot_button_label" name="chatbot_button_label" class="form-control" value="{$config.chatbot_button_label|escape}" placeholder="{$chatbot_defaults.chatbot_button_label|escape}">
                                                <span class="chatbot-helper">Kosongkan untuk memakai judul chat sebagai teks tombol.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_button_side">Button Position</label>
                                                <select id="chatbot_button_side" name="chatbot_button_side" class="form-control">
                                                    <option value="right" {if $config.chatbot_button_side == 'right'}selected{/if}>Right</option>
                                                    <option value="left" {if $config.chatbot_button_side == 'left'}selected{/if}>Left</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_avatar_url">Avatar URL</label>
                                                <input type="url" id="chatbot_avatar_url" name="chatbot_avatar_url" class="form-control" value="{$config.chatbot_avatar_url|escape}" placeholder="https://cdn.example.com/avatar.png">
                                                <span class="chatbot-helper">Opsional, gunakan gambar 1:1 untuk ikon chatbot.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_frame_mode">Frame Mode</label>
                                                <select id="chatbot_frame_mode" name="chatbot_frame_mode" class="form-control">
                                                    <option value="fixed" {if $config.chatbot_frame_mode == 'fixed'}selected{/if}>Fixed size</option>
                                                    <option value="auto" {if $config.chatbot_frame_mode == 'auto'}selected{/if}>Auto fit height</option>
                                                </select>
                                            </div>
                                            <div class="form-group" data-frame-mode="fixed">
                                                <label for="chatbot_frame_width">Frame Width (px)</label>
                                                <input type="number" min="280" max="640" id="chatbot_frame_width" name="chatbot_frame_width" class="form-control" value="{$config.chatbot_frame_width|escape}">
                                            </div>
                                            <div class="form-group" data-frame-mode="fixed">
                                                <label for="chatbot_frame_height">Frame Height (px)</label>
                                                <input type="number" min="320" max="800" id="chatbot_frame_height" name="chatbot_frame_height" class="form-control" value="{$config.chatbot_frame_height|escape}">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Interaksi Pengguna</h3>
                                        <p class="chatbot-card__subtitle">Kelola pesan sambutan, animasi mengetik, serta batas input.</p>
                                        <div class="chatbot-grid">
                                            <div class="form-group">
                                                <label for="chatbot_welcome_enabled">Enable Welcome Message</label>
                                                <select id="chatbot_welcome_enabled" name="chatbot_welcome_enabled" class="form-control">
                                                    <option value="1" {if $config.chatbot_welcome_enabled == '1'}selected{/if}>Yes</option>
                                                    <option value="0" {if $config.chatbot_welcome_enabled == '0'}selected{/if}>No</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_message_format">Message Format</label>
                                                <select id="chatbot_message_format" name="chatbot_message_format" class="form-control">
                                                    <option value="plain" {if $config.chatbot_message_format == 'plain'}selected{/if}>Plain text</option>
                                                    <option value="markdown" {if $config.chatbot_message_format == 'markdown'}selected{/if}>Markdown (safe)</option>
                                                    <option value="markdown_v2" {if $config.chatbot_message_format == 'markdown_v2'}selected{/if}>Markdown V2 (underline/spoiler)</option>
                                                </select>
                                                <span class="chatbot-helper">Markdown mendukung <strong>bold</strong>, <em>italic</em>, <code>code</code>, daftar, quote, link. V2 menambah <u>underline</u> &amp; spoiler.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_typing_mode">Typing Indicator</label>
                                                <select id="chatbot_typing_mode" name="chatbot_typing_mode" class="form-control">
                                                    <option value="off" {if $config.chatbot_typing_mode == 'off'}selected{/if}>Disabled</option>
                                                    <option value="wpm" {if $config.chatbot_typing_mode == 'wpm'}selected{/if}>Simulate typing speed</option>
                                                </select>
                                            </div>
                                            <div class="form-group" data-typing-mode="wpm">
                                                <label for="chatbot_typing_wpm">Typing Speed (WPM)</label>
                                                <input type="number" min="60" max="900" id="chatbot_typing_wpm" name="chatbot_typing_wpm" class="form-control" value="{$config.chatbot_typing_wpm|escape}">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_user_input_max_chars">Max Message Length</label>
                                                <input type="number" min="100" max="4000" id="chatbot_user_input_max_chars" name="chatbot_user_input_max_chars" class="form-control" value="{$config.chatbot_user_input_max_chars|escape}">
                                            </div>
                                            <div class="form-group" style="grid-column: 1 / -1;">
                                                <label for="chatbot_welcome_message">Welcome Message</label>
                                                <textarea id="chatbot_welcome_message" name="chatbot_welcome_message" class="form-control">{$config.chatbot_welcome_message|escape}</textarea>
                                                <span class="chatbot-helper">Pesan pertama yang dikirim chatbot ketika panel dibuka pertama kali.</span>
                                            </div>
                                        </div>
                                    </div>

                                {/if}

                                {if $chatbot_active_section eq 'styling'}
                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Header &amp; Buttons</h3>
                                        <p class="chatbot-card__subtitle">Atur tampilan header chat, launcher, dan tombol kirim.</p>
                                        <div class="chatbot-grid">
                                            <div class="form-group">
                                                <label for="chatbot_header_bg">Header Background</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_header_bg" name="chatbot_header_bg" class="form-control js-chatbot-color-text" value="{$config.chatbot_header_bg|escape}" placeholder="linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-accent))">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_header_bg_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_header_bg" value="#0d9488" aria-label="Pick header background">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_header_bg">
                                                        <option value="">Tema default (gradient)</option>
                                                        <option value="linear-gradient(135deg, #0d9488, #06b6d4)">Teal gradient</option>
                                                        <option value="linear-gradient(135deg, #2563eb, #1d4ed8)">Blue gradient</option>
                                                        <option value="linear-gradient(135deg, #7c3aed, #6d28d9)">Purple gradient</option>
                                                        <option value="linear-gradient(135deg, #f97316, #ea580c)">Orange gradient</option>
                                                        <option value="linear-gradient(135deg, #111827, #334155)">Slate gradient</option>
                                                        <option value="#0f172a">Solid dark</option>
                                                    </select>
                                                    </div>
                                                </div>
                                                <span class="chatbot-helper">Kosongkan untuk memakai tema default. Color picker hanya untuk warna solid.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_header_text">Header Text Color</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_header_text" name="chatbot_header_text" class="form-control js-chatbot-color-text" value="{$config.chatbot_header_text|escape}" placeholder="#ffffff">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_header_text_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_header_text" value="#ffffff" aria-label="Pick header text color">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_header_text">
                                                        <option value="">Tema default</option>
                                                        <option value="#ffffff">White</option>
                                                        <option value="#f8fafc">Soft White</option>
                                                        <option value="#0f172a">Dark</option>
                                                    </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_launcher_bg">Launcher Button Background</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_launcher_bg" name="chatbot_launcher_bg" class="form-control js-chatbot-color-text" value="{$config.chatbot_launcher_bg|escape}" placeholder="linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-primary-strong))">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_launcher_bg_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_launcher_bg" value="#0d9488" aria-label="Pick launcher background">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_launcher_bg">
                                                        <option value="">Tema default (gradient)</option>
                                                        <option value="linear-gradient(135deg, #0d9488, #0f766e)">Teal gradient</option>
                                                        <option value="linear-gradient(135deg, #2563eb, #1d4ed8)">Blue gradient</option>
                                                        <option value="linear-gradient(135deg, #7c3aed, #6d28d9)">Purple gradient</option>
                                                        <option value="linear-gradient(135deg, #f97316, #ea580c)">Orange gradient</option>
                                                        <option value="linear-gradient(135deg, #111827, #334155)">Slate gradient</option>
                                                        <option value="#0f172a">Solid dark</option>
                                                    </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_launcher_text">Launcher Text Color</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_launcher_text" name="chatbot_launcher_text" class="form-control js-chatbot-color-text" value="{$config.chatbot_launcher_text|escape}" placeholder="#ffffff">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_launcher_text_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_launcher_text" value="#ffffff" aria-label="Pick launcher text color">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_launcher_text">
                                                        <option value="">Tema default</option>
                                                        <option value="#ffffff">White</option>
                                                        <option value="#0f172a">Dark</option>
                                                    </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_send_bg">Send Button Background</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_send_bg" name="chatbot_send_bg" class="form-control js-chatbot-color-text" value="{$config.chatbot_send_bg|escape}" placeholder="linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-accent))">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_send_bg_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_send_bg" value="#0d9488" aria-label="Pick send button background">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_send_bg">
                                                        <option value="">Tema default (gradient)</option>
                                                        <option value="linear-gradient(135deg, #0d9488, #06b6d4)">Teal gradient</option>
                                                        <option value="linear-gradient(135deg, #2563eb, #1d4ed8)">Blue gradient</option>
                                                        <option value="linear-gradient(135deg, #7c3aed, #6d28d9)">Purple gradient</option>
                                                        <option value="linear-gradient(135deg, #f97316, #ea580c)">Orange gradient</option>
                                                        <option value="linear-gradient(135deg, #111827, #334155)">Slate gradient</option>
                                                        <option value="#0f172a">Solid dark</option>
                                                    </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_send_text">Send Icon Color</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_send_text" name="chatbot_send_text" class="form-control js-chatbot-color-text" value="{$config.chatbot_send_text|escape}" placeholder="#ffffff">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_send_text_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_send_text" value="#ffffff" aria-label="Pick send icon color">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_send_text">
                                                        <option value="">Tema default</option>
                                                        <option value="#ffffff">White</option>
                                                        <option value="#e2e8f0">Soft Gray</option>
                                                        <option value="#0f172a">Dark</option>
                                                    </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Chat Box &amp; Input</h3>
                                        <p class="chatbot-card__subtitle">Atur warna panel chat, area pesan, dan input.</p>
                                        <div class="chatbot-grid">
                                            <div class="form-group">
                                                <label for="chatbot_frame_bg">Chat Box Background</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_frame_bg" name="chatbot_frame_bg" class="form-control js-chatbot-color-text" value="{$config.chatbot_frame_bg|escape}" placeholder="var(--chatbot-surface)">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_frame_bg_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_frame_bg" value="#ffffff" aria-label="Pick chat box background">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_frame_bg">
                                                            <option value="">Tema default</option>
                                                            <option value="#ffffff">White</option>
                                                            <option value="#f8fafc">Soft Gray</option>
                                                            <option value="#eef2ff">Soft Indigo</option>
                                                            <option value="#0f172a">Dark</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_messages_bg">Messages Background</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_messages_bg" name="chatbot_messages_bg" class="form-control js-chatbot-color-text" value="{$config.chatbot_messages_bg|escape}" placeholder="var(--chatbot-bg)">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_messages_bg_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_messages_bg" value="#f1f6f8" aria-label="Pick messages background">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_messages_bg">
                                                            <option value="">Tema default</option>
                                                            <option value="#f1f6f8">Soft Gray</option>
                                                            <option value="#eef2ff">Soft Indigo</option>
                                                            <option value="#ecfeff">Soft Cyan</option>
                                                            <option value="#0b1220">Dark</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_input_bg">Input Background</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_input_bg" name="chatbot_input_bg" class="form-control js-chatbot-color-text" value="{$config.chatbot_input_bg|escape}" placeholder="#f8fafc">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_input_bg_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_input_bg" value="#f8fafc" aria-label="Pick input background">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_input_bg">
                                                            <option value="">Tema default</option>
                                                            <option value="#f8fafc">Soft Gray</option>
                                                            <option value="#ffffff">White</option>
                                                            <option value="#eef2ff">Soft Indigo</option>
                                                            <option value="#0b1220">Dark</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_input_text">Input Text Color</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_input_text" name="chatbot_input_text" class="form-control js-chatbot-color-text" value="{$config.chatbot_input_text|escape}" placeholder="var(--chatbot-text)">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_input_text_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_input_text" value="#0f172a" aria-label="Pick input text color">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_input_text">
                                                            <option value="">Tema default</option>
                                                            <option value="#0f172a">Dark</option>
                                                            <option value="#1f2937">Gray 800</option>
                                                            <option value="#ffffff">White</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_input_border">Input Border Color</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_input_border" name="chatbot_input_border" class="form-control js-chatbot-color-text" value="{$config.chatbot_input_border|escape}" placeholder="rgba(148, 163, 184, 0.45)">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_input_border_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_input_border" value="#94a3b8" aria-label="Pick input border color">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_input_border">
                                                            <option value="">Tema default</option>
                                                            <option value="#94a3b8">Slate 400</option>
                                                            <option value="#cbd5f5">Slate 300</option>
                                                            <option value="#e2e8f0">Slate 200</option>
                                                            <option value="transparent">Transparent</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_input_area_bg">Input Bar Background</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_input_area_bg" name="chatbot_input_area_bg" class="form-control js-chatbot-color-text" value="{$config.chatbot_input_area_bg|escape}" placeholder="rgba(255, 255, 255, 0.95)">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_input_area_bg_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_input_area_bg" value="#ffffff" aria-label="Pick input bar background">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_input_area_bg">
                                                            <option value="">Tema default</option>
                                                            <option value="rgba(255, 255, 255, 0.95)">Light glass</option>
                                                            <option value="rgba(15, 23, 42, 0.85)">Dark glass</option>
                                                            <option value="#ffffff">Solid white</option>
                                                            <option value="#0f172a">Solid dark</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <span class="chatbot-helper">Glass cocok untuk efek blur. Color picker hanya untuk solid.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_input_area_padding_x">Input Bar Padding X (px)</label>
                                                <input type="number" min="6" max="24" id="chatbot_input_area_padding_x" name="chatbot_input_area_padding_x" class="form-control" value="{$config.chatbot_input_area_padding_x|escape}">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_input_area_padding_y">Input Bar Padding Y (px)</label>
                                                <input type="number" min="6" max="24" id="chatbot_input_area_padding_y" name="chatbot_input_area_padding_y" class="form-control" value="{$config.chatbot_input_area_padding_y|escape}">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_input_area_blur">Input Bar Blur (px)</label>
                                                <input type="number" min="0" max="20" id="chatbot_input_area_blur" name="chatbot_input_area_blur" class="form-control" value="{$config.chatbot_input_area_blur|escape}">
                                                <span class="chatbot-helper">Isi 0 untuk menonaktifkan blur.</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Bubble &amp; Typography</h3>
                                        <p class="chatbot-card__subtitle">Sesuaikan warna bubble, ukuran teks, padding, dan font agar tampilan chat konsisten.</p>
                                        <div class="chatbot-grid">
                                            <div class="form-group">
                                                <label for="chatbot_bubble_bot_bg">Bot Bubble Background</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_bubble_bot_bg" name="chatbot_bubble_bot_bg" class="form-control js-chatbot-color-text" value="{$config.chatbot_bubble_bot_bg|escape}" placeholder="var(--chatbot-surface)">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_bubble_bot_bg_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_bubble_bot_bg" value="#ffffff" aria-label="Pick bot bubble background">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_bubble_bot_bg">
                                                        <option value="">Tema default</option>
                                                        <option value="#ffffff">White</option>
                                                        <option value="#f8fafc">Soft Gray</option>
                                                        <option value="#eff6ff">Soft Blue</option>
                                                        <option value="#ecfeff">Soft Cyan</option>
                                                        <option value="#f0fdf4">Soft Green</option>
                                                        <option value="#f5f3ff">Soft Purple</option>
                                                        <option value="#fff1f2">Soft Rose</option>
                                                        <option value="#111827">Slate 900</option>
                                                    </select>
                                                    </div>
                                                </div>
                                                <span class="chatbot-helper">Kosongkan untuk mengikuti tema. Color picker hanya untuk warna solid.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_bot_text">Bot Text Color</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_bubble_bot_text" name="chatbot_bubble_bot_text" class="form-control js-chatbot-color-text" value="{$config.chatbot_bubble_bot_text|escape}" placeholder="var(--chatbot-text)">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_bubble_bot_text_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_bubble_bot_text" value="#0f172a" aria-label="Pick bot text color">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_bubble_bot_text">
                                                        <option value="">Tema default</option>
                                                        <option value="#0f172a">Slate 900</option>
                                                        <option value="#1f2937">Gray 800</option>
                                                        <option value="#475569">Slate 600</option>
                                                        <option value="#0f766e">Teal 700</option>
                                                        <option value="#0ea5e9">Sky 500</option>
                                                        <option value="#ffffff">White</option>
                                                    </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_bot_border">Bot Border Color</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_bubble_bot_border" name="chatbot_bubble_bot_border" class="form-control js-chatbot-color-text" value="{$config.chatbot_bubble_bot_border|escape}" placeholder="var(--chatbot-border)">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_bubble_bot_border_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_bubble_bot_border" value="#e2e8f0" aria-label="Pick bot border color">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_bubble_bot_border">
                                                        <option value="">Tema default</option>
                                                        <option value="#e2e8f0">Slate 200</option>
                                                        <option value="#cbd5f5">Slate 300</option>
                                                        <option value="#94a3b8">Slate 400</option>
                                                        <option value="transparent">Transparent</option>
                                                    </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_user_bg">User Bubble Background</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_bubble_user_bg" name="chatbot_bubble_user_bg" class="form-control js-chatbot-color-text" value="{$config.chatbot_bubble_user_bg|escape}" placeholder="linear-gradient(135deg, var(--chatbot-primary), var(--chatbot-primary-strong))">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_bubble_user_bg_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_bubble_user_bg" value="#0d9488" aria-label="Pick user bubble background">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_bubble_user_bg">
                                                        <option value="">Tema default (gradient)</option>
                                                        <option value="linear-gradient(135deg, #0d9488, #0f766e)">Teal gradient</option>
                                                        <option value="linear-gradient(135deg, #2563eb, #1d4ed8)">Blue gradient</option>
                                                        <option value="linear-gradient(135deg, #7c3aed, #6d28d9)">Purple gradient</option>
                                                        <option value="linear-gradient(135deg, #f97316, #ea580c)">Orange gradient</option>
                                                        <option value="linear-gradient(135deg, #111827, #334155)">Slate gradient</option>
                                                        <option value="#0f172a">Solid dark</option>
                                                    </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_user_text">User Text Color</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_bubble_user_text" name="chatbot_bubble_user_text" class="form-control js-chatbot-color-text" value="{$config.chatbot_bubble_user_text|escape}" placeholder="#ffffff">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_bubble_user_text_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_bubble_user_text" value="#ffffff" aria-label="Pick user text color">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_bubble_user_text">
                                                        <option value="">Tema default</option>
                                                        <option value="#ffffff">White</option>
                                                        <option value="#f8fafc">Soft White</option>
                                                        <option value="#0f172a">Dark</option>
                                                    </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_user_border">User Border Color</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_bubble_user_border" name="chatbot_bubble_user_border" class="form-control js-chatbot-color-text" value="{$config.chatbot_bubble_user_border|escape}" placeholder="transparent">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <input type="color" id="chatbot_bubble_user_border_picker" class="form-control chatbot-color-input js-chatbot-color-picker" data-text-input="chatbot_bubble_user_border" value="#0d9488" aria-label="Pick user border color">
                                                        <select class="form-control chatbot-select-compact js-chatbot-color-preset" data-text-input="chatbot_bubble_user_border">
                                                        <option value="">Tema default</option>
                                                        <option value="transparent">Transparent</option>
                                                        <option value="#0d9488">Teal</option>
                                                        <option value="#2563eb">Blue</option>
                                                        <option value="#7c3aed">Purple</option>
                                                    </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_radius">Bubble Radius (px)</label>
                                                <input type="number" min="0" max="40" id="chatbot_bubble_radius" name="chatbot_bubble_radius" class="form-control" value="{$config.chatbot_bubble_radius|escape}">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_padding_y">Bubble Padding Y (px)</label>
                                                <input type="number" min="0" max="30" id="chatbot_bubble_padding_y" name="chatbot_bubble_padding_y" class="form-control" value="{$config.chatbot_bubble_padding_y|escape}">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_padding_x">Bubble Padding X (px)</label>
                                                <input type="number" min="0" max="30" id="chatbot_bubble_padding_x" name="chatbot_bubble_padding_x" class="form-control" value="{$config.chatbot_bubble_padding_x|escape}">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_font_size">Bubble Font Size (px)</label>
                                                <input type="number" min="10" max="20" id="chatbot_bubble_font_size" name="chatbot_bubble_font_size" class="form-control" value="{$config.chatbot_bubble_font_size|escape}">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_line_height">Bubble Line Height</label>
                                                <input type="number" step="0.05" min="1.1" max="2" id="chatbot_bubble_line_height" name="chatbot_bubble_line_height" class="form-control" value="{$config.chatbot_bubble_line_height|escape}">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_bubble_max_width">Bubble Max Width (%)</label>
                                                <input type="number" min="60" max="100" id="chatbot_bubble_max_width" name="chatbot_bubble_max_width" class="form-control" value="{$config.chatbot_bubble_max_width|escape}">
                                                <span class="chatbot-helper">Mengatur lebar maksimum bubble relatif terhadap area chat.</span>
                                            </div>
                                            <div class="form-group" style="grid-column: 1 / -1;">
                                                <label for="chatbot_message_font_family">Message Font Family</label>
                                                <div class="chatbot-field-row chatbot-field-row--with-advanced">
                                                    <div class="chatbot-advanced-field">
                                                        <input type="text" id="chatbot_message_font_family" name="chatbot_message_font_family" class="form-control js-chatbot-font-text" value="{$config.chatbot_message_font_family|escape}" placeholder="Poppins, sans-serif">
                                                    </div>
                                                    <div class="chatbot-field-controls">
                                                        <select class="form-control chatbot-select-compact js-chatbot-font-preset" data-text-input="chatbot_message_font_family">
                                                            <option value="">Tema default</option>
                                                            <option value="system-ui, -apple-system, \"Segoe UI\", sans-serif">System UI</option>
                                                            <option value="Poppins, \"Segoe UI\", sans-serif">Poppins</option>
                                                            <option value="\"Plus Jakarta Sans\", \"Segoe UI\", sans-serif">Plus Jakarta Sans</option>
                                                            <option value="\"DM Sans\", \"Segoe UI\", sans-serif">DM Sans</option>
                                                            <option value="\"IBM Plex Sans\", \"Segoe UI\", sans-serif">IBM Plex Sans</option>
                                                            <option value="\"Inter\", \"Segoe UI\", sans-serif">Inter</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <span class="chatbot-helper">Kosongkan untuk mengikuti font default tema. Pilih preset atau isi custom.</span>
                                            </div>
                                        </div>
                                    </div>
                                    </div>
                                {/if}

                                {if $chatbot_active_section eq 'chat-experience'}
                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Kebijakan Histori</h3>
                                        <p class="chatbot-card__subtitle">Atur bagaimana riwayat percakapan disimpan di sisi browser pengguna.</p>
                                        <div class="chatbot-grid">
                                            <div class="form-group">
                                                <label for="chatbot_history_mode">History Mode</label>
                                                <select id="chatbot_history_mode" name="chatbot_history_mode" class="form-control">
                                                    <option value="ttl" {if $config.chatbot_history_mode == 'ttl'}selected{/if}>Time To Live (TTL)</option>
                                                    <option value="count" {if $config.chatbot_history_mode == 'count'}selected{/if}>Max Messages</option>
                                                </select>
                                                <span class="chatbot-helper">TTL akan membersihkan riwayat berdasarkan umur pesan, Count berdasarkan jumlah pesan terakhir.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_history_ttl">History TTL (menit)</label>
                                                <input type="number" min="30" id="chatbot_history_ttl" name="chatbot_history_ttl" class="form-control" value="{$config.chatbot_history_ttl|escape}">
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_history_max_messages">History Max Messages</label>
                                                <input type="number" min="1" id="chatbot_history_max_messages" name="chatbot_history_max_messages" class="form-control" value="{$config.chatbot_history_max_messages|escape}">
                                            </div>
                                        </div>
                                    </div>
                                {/if}

                            </div>
                        </div>
                        <div class="chatbot-form-actions">
                            <div class="chatbot-form-note">AI Chatbot didukung dan terintegrasi penuh dengan <a href="https://gateway.drnet.biz.id" target="_blank" rel="noopener noreferrer">DRNet Gateway</a>.</div>
                            <button type="submit" name="save" value="save" class="btn btn-primary">Save Settings</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

{literal}
<script>
(function(){
    var authSelect = document.getElementById('chatbot_auth_type');
    var authBlocks = document.querySelectorAll('.js-auth-block');
    function syncAuth(){
        if(!authSelect){ return; }
        var mode = authSelect.value;
        authBlocks.forEach(function(block){
            var required = (block.getAttribute('data-auth-mode') || '').split(',');
            if(required.indexOf(mode) !== -1){
                block.classList.add('is-active');
            } else {
                block.classList.remove('is-active');
            }
        });
    }
    if(authSelect){ authSelect.addEventListener('change', syncAuth); syncAuth(); }

    var adminEndpointToggle = document.getElementById('chatbot_admin_endpoint_enabled');
    var adminEndpointBlocks = document.querySelectorAll('.js-admin-endpoint-block');
    function syncAdminEndpoint(){
        if(!adminEndpointToggle){ return; }
        var enabled = adminEndpointToggle.value === '1';
        adminEndpointBlocks.forEach(function(block){
            if(enabled){
                block.classList.add('is-active');
            } else {
                block.classList.remove('is-active');
            }
        });
    }
    if(adminEndpointToggle){ adminEndpointToggle.addEventListener('change', syncAdminEndpoint); syncAdminEndpoint(); }

    var adminAuthSelect = document.getElementById('chatbot_admin_auth_type');
    var adminAuthBlocks = document.querySelectorAll('.js-admin-auth-block');
    function syncAdminAuth(){
        if(!adminAuthSelect){ return; }
        var mode = adminAuthSelect.value;
        adminAuthBlocks.forEach(function(block){
            var required = (block.getAttribute('data-auth-mode') || '').split(',');
            if(required.indexOf(mode) !== -1){
                block.classList.add('is-active');
            } else {
                block.classList.remove('is-active');
            }
        });
    }
    if(adminAuthSelect){ adminAuthSelect.addEventListener('change', syncAdminAuth); syncAdminAuth(); }

    var typingSelect = document.getElementById('chatbot_typing_mode');
    var typingBlocks = document.querySelectorAll('[data-typing-mode]');
    function syncTyping(){
        if(!typingSelect){ return; }
        var mode = typingSelect.value;
        typingBlocks.forEach(function(block){
            block.style.display = (block.getAttribute('data-typing-mode') === mode) ? '' : 'none';
        });
    }
    if(typingSelect){ typingSelect.addEventListener('change', syncTyping); syncTyping(); }

    var frameSelect = document.getElementById('chatbot_frame_mode');
    var frameBlocks = document.querySelectorAll('[data-frame-mode]');
    function syncFrame(){
        if(!frameSelect){ return; }
        var mode = frameSelect.value;
        frameBlocks.forEach(function(block){
            block.style.display = (block.getAttribute('data-frame-mode') === mode) ? '' : 'none';
        });
    }
    if(frameSelect){ frameSelect.addEventListener('change', syncFrame); syncFrame(); }

    var advancedToggle = document.getElementById('chatbot_show_advanced_controls');
    var advancedRows = document.querySelectorAll('.chatbot-field-row--with-advanced');
    function setAdvancedMode(isOn){
        advancedRows.forEach(function(row){
            if(isOn){
                row.classList.add('is-advanced');
            } else {
                row.classList.remove('is-advanced');
            }
        });
    }
    if(advancedToggle){
        var storedAdvanced = localStorage.getItem('ai_chatbot_admin_advanced');
        var initialAdvanced = storedAdvanced === '1';
        advancedToggle.checked = initialAdvanced;
        setAdvancedMode(initialAdvanced);
        advancedToggle.addEventListener('change', function(){
            var enabled = advancedToggle.checked;
            localStorage.setItem('ai_chatbot_admin_advanced', enabled ? '1' : '0');
            setAdvancedMode(enabled);
        });
    }

    function isHexColor(value){
        return /^#([0-9a-f]{3}){1,2}$/i.test(value || '');
    }

    function syncPickerWithText(textInput){
        if(!textInput){ return; }
        var pickerId = textInput.getAttribute('data-color-picker') || '';
        var picker = pickerId ? document.getElementById(pickerId) : null;
        if(!picker){ return; }
        var value = textInput.value.trim();
        if(isHexColor(value)){
            picker.value = value;
        }
    }

    document.querySelectorAll('.js-chatbot-color-picker').forEach(function(picker){
        var textId = picker.getAttribute('data-text-input');
        var textInput = textId ? document.getElementById(textId) : null;
        if(textInput){ textInput.setAttribute('data-color-picker', picker.id); }
        if(textInput && isHexColor(textInput.value.trim())){
            picker.value = textInput.value.trim();
        }
        picker.addEventListener('input', function(){
            if(textInput){ textInput.value = picker.value; }
        });
    });

    document.querySelectorAll('.js-chatbot-color-text').forEach(function(textInput){
        textInput.addEventListener('input', function(){ syncPickerWithText(textInput); });
    });

    document.querySelectorAll('.js-chatbot-color-preset').forEach(function(select){
        var textId = select.getAttribute('data-text-input');
        var textInput = textId ? document.getElementById(textId) : null;
        select.addEventListener('change', function(){
            if(!textInput){ return; }
            textInput.value = select.value;
            syncPickerWithText(textInput);
        });
    });

    document.querySelectorAll('.js-chatbot-font-preset').forEach(function(select){
        var textId = select.getAttribute('data-text-input');
        var textInput = textId ? document.getElementById(textId) : null;
        select.addEventListener('change', function(){
            if(!textInput){ return; }
            textInput.value = select.value;
        });
    });

    var themeSelect = document.getElementById('chatbot_theme_preset');
    var applyingTheme = false;
    var customSettings = document.querySelectorAll('.js-chatbot-custom-settings');
    var themeHints = document.querySelectorAll('.js-chatbot-theme-hint');
    var chatbotThemes = {
        ocean: {
            chatbot_header_bg: 'linear-gradient(135deg, #0d9488, #06b6d4)',
            chatbot_header_text: '#ffffff',
            chatbot_launcher_bg: 'linear-gradient(135deg, #0d9488, #0f766e)',
            chatbot_launcher_text: '#ffffff',
            chatbot_send_bg: 'linear-gradient(135deg, #0d9488, #06b6d4)',
            chatbot_send_text: '#ffffff',
            chatbot_frame_bg: '#ffffff',
            chatbot_messages_bg: '#f1f6f8',
            chatbot_input_bg: '#f8fafc',
            chatbot_input_text: '#0f172a',
            chatbot_input_border: '#94a3b8',
            chatbot_input_area_bg: 'rgba(255, 255, 255, 0.95)',
            chatbot_input_area_padding_x: '14',
            chatbot_input_area_padding_y: '12',
            chatbot_input_area_blur: '8',
            chatbot_bubble_bot_bg: '#ffffff',
            chatbot_bubble_bot_text: '#0f172a',
            chatbot_bubble_bot_border: '#e2e8f0',
            chatbot_bubble_user_bg: 'linear-gradient(135deg, #0d9488, #0f766e)',
            chatbot_bubble_user_text: '#ffffff',
            chatbot_bubble_user_border: 'transparent',
            chatbot_bubble_radius: '14',
            chatbot_bubble_padding_x: '14',
            chatbot_bubble_padding_y: '10',
            chatbot_bubble_font_size: '14',
            chatbot_bubble_line_height: '1.45',
            chatbot_bubble_max_width: '80',
            chatbot_message_font_family: 'Poppins, \"Segoe UI\", sans-serif'
        },
        dark_glass: {
            chatbot_header_bg: 'linear-gradient(135deg, #0f172a, #1f2937)',
            chatbot_header_text: '#e2e8f0',
            chatbot_launcher_bg: 'linear-gradient(135deg, #111827, #1f2937)',
            chatbot_launcher_text: '#e2e8f0',
            chatbot_send_bg: 'linear-gradient(135deg, #1f2937, #0f172a)',
            chatbot_send_text: '#e2e8f0',
            chatbot_frame_bg: 'linear-gradient(180deg, #0f172a 0%, #0b1220 100%)',
            chatbot_messages_bg: 'linear-gradient(180deg, #0b1220 0%, #111827 100%)',
            chatbot_input_bg: '#0b1220',
            chatbot_input_text: '#e2e8f0',
            chatbot_input_border: 'rgba(148, 163, 184, 0.35)',
            chatbot_input_area_bg: 'rgba(15, 23, 42, 0.85)',
            chatbot_input_area_padding_x: '14',
            chatbot_input_area_padding_y: '12',
            chatbot_input_area_blur: '10',
            chatbot_bubble_bot_bg: 'rgba(15, 23, 42, 0.7)',
            chatbot_bubble_bot_text: '#e2e8f0',
            chatbot_bubble_bot_border: 'rgba(148, 163, 184, 0.25)',
            chatbot_bubble_user_bg: 'linear-gradient(135deg, #2563eb, #1d4ed8)',
            chatbot_bubble_user_text: '#ffffff',
            chatbot_bubble_user_border: 'transparent',
            chatbot_bubble_radius: '16',
            chatbot_bubble_padding_x: '14',
            chatbot_bubble_padding_y: '10',
            chatbot_bubble_font_size: '14',
            chatbot_bubble_line_height: '1.45',
            chatbot_bubble_max_width: '82',
            chatbot_message_font_family: '\"Plus Jakarta Sans\", \"Segoe UI\", sans-serif'
        },
        minimal: {
            chatbot_header_bg: '#ffffff',
            chatbot_header_text: '#0f172a',
            chatbot_launcher_bg: '#ffffff',
            chatbot_launcher_text: '#0f172a',
            chatbot_send_bg: '#0f172a',
            chatbot_send_text: '#ffffff',
            chatbot_frame_bg: '#ffffff',
            chatbot_messages_bg: '#ffffff',
            chatbot_input_bg: '#ffffff',
            chatbot_input_text: '#0f172a',
            chatbot_input_border: '#e2e8f0',
            chatbot_input_area_bg: '#ffffff',
            chatbot_input_area_padding_x: '12',
            chatbot_input_area_padding_y: '10',
            chatbot_input_area_blur: '0',
            chatbot_bubble_bot_bg: '#f8fafc',
            chatbot_bubble_bot_text: '#0f172a',
            chatbot_bubble_bot_border: '#e2e8f0',
            chatbot_bubble_user_bg: '#0f172a',
            chatbot_bubble_user_text: '#ffffff',
            chatbot_bubble_user_border: 'transparent',
            chatbot_bubble_radius: '10',
            chatbot_bubble_padding_x: '12',
            chatbot_bubble_padding_y: '8',
            chatbot_bubble_font_size: '14',
            chatbot_bubble_line_height: '1.4',
            chatbot_bubble_max_width: '78',
            chatbot_message_font_family: 'system-ui, -apple-system, \"Segoe UI\", sans-serif'
        },
        neon: {
            chatbot_header_bg: 'linear-gradient(135deg, #7c3aed, #ec4899)',
            chatbot_header_text: '#ffffff',
            chatbot_launcher_bg: 'linear-gradient(135deg, #7c3aed, #6d28d9)',
            chatbot_launcher_text: '#ffffff',
            chatbot_send_bg: 'linear-gradient(135deg, #ec4899, #f97316)',
            chatbot_send_text: '#ffffff',
            chatbot_frame_bg: '#0b1220',
            chatbot_messages_bg: '#0b1220',
            chatbot_input_bg: '#111827',
            chatbot_input_text: '#e2e8f0',
            chatbot_input_border: '#334155',
            chatbot_input_area_bg: 'rgba(15, 23, 42, 0.85)',
            chatbot_input_area_padding_x: '14',
            chatbot_input_area_padding_y: '12',
            chatbot_input_area_blur: '12',
            chatbot_bubble_bot_bg: '#111827',
            chatbot_bubble_bot_text: '#e2e8f0',
            chatbot_bubble_bot_border: '#334155',
            chatbot_bubble_user_bg: 'linear-gradient(135deg, #7c3aed, #ec4899)',
            chatbot_bubble_user_text: '#ffffff',
            chatbot_bubble_user_border: 'transparent',
            chatbot_bubble_radius: '16',
            chatbot_bubble_padding_x: '14',
            chatbot_bubble_padding_y: '10',
            chatbot_bubble_font_size: '14',
            chatbot_bubble_line_height: '1.5',
            chatbot_bubble_max_width: '82',
            chatbot_message_font_family: '\"DM Sans\", \"Segoe UI\", sans-serif'
        },
        forest: {
            chatbot_header_bg: 'linear-gradient(135deg, #166534, #22c55e)',
            chatbot_header_text: '#ffffff',
            chatbot_launcher_bg: 'linear-gradient(135deg, #166534, #15803d)',
            chatbot_launcher_text: '#ffffff',
            chatbot_send_bg: 'linear-gradient(135deg, #16a34a, #22c55e)',
            chatbot_send_text: '#ffffff',
            chatbot_frame_bg: '#ffffff',
            chatbot_messages_bg: '#f0fdf4',
            chatbot_input_bg: '#f8fafc',
            chatbot_input_text: '#0f172a',
            chatbot_input_border: '#86efac',
            chatbot_input_area_bg: 'rgba(255, 255, 255, 0.92)',
            chatbot_input_area_padding_x: '14',
            chatbot_input_area_padding_y: '12',
            chatbot_input_area_blur: '6',
            chatbot_bubble_bot_bg: '#ffffff',
            chatbot_bubble_bot_text: '#0f172a',
            chatbot_bubble_bot_border: '#bbf7d0',
            chatbot_bubble_user_bg: 'linear-gradient(135deg, #16a34a, #22c55e)',
            chatbot_bubble_user_text: '#ffffff',
            chatbot_bubble_user_border: 'transparent',
            chatbot_bubble_radius: '14',
            chatbot_bubble_padding_x: '14',
            chatbot_bubble_padding_y: '10',
            chatbot_bubble_font_size: '14',
            chatbot_bubble_line_height: '1.45',
            chatbot_bubble_max_width: '80',
            chatbot_message_font_family: '\"IBM Plex Sans\", \"Segoe UI\", sans-serif'
        },
        modern: {
            chatbot_header_bg: 'linear-gradient(135deg, #111827, #1f2937)',
            chatbot_header_text: '#f9fafb',
            chatbot_launcher_bg: 'linear-gradient(135deg, #0ea5e9, #2563eb)',
            chatbot_launcher_text: '#ffffff',
            chatbot_send_bg: 'linear-gradient(135deg, #0ea5e9, #2563eb)',
            chatbot_send_text: '#ffffff',
            chatbot_frame_bg: '#ffffff',
            chatbot_messages_bg: '#f8fafc',
            chatbot_input_bg: '#ffffff',
            chatbot_input_text: '#0f172a',
            chatbot_input_border: '#cbd5f5',
            chatbot_input_area_bg: 'rgba(255, 255, 255, 0.94)',
            chatbot_input_area_padding_x: '14',
            chatbot_input_area_padding_y: '12',
            chatbot_input_area_blur: '8',
            chatbot_bubble_bot_bg: '#ffffff',
            chatbot_bubble_bot_text: '#0f172a',
            chatbot_bubble_bot_border: '#e2e8f0',
            chatbot_bubble_user_bg: 'linear-gradient(135deg, #0ea5e9, #2563eb)',
            chatbot_bubble_user_text: '#ffffff',
            chatbot_bubble_user_border: 'transparent',
            chatbot_bubble_radius: '14',
            chatbot_bubble_padding_x: '14',
            chatbot_bubble_padding_y: '10',
            chatbot_bubble_font_size: '14',
            chatbot_bubble_line_height: '1.45',
            chatbot_bubble_max_width: '80',
            chatbot_message_font_family: '\"Outfit\", \"Segoe UI\", sans-serif'
        },
        aesthetic: {
            chatbot_header_bg: 'linear-gradient(135deg, #f472b6, #a855f7)',
            chatbot_header_text: '#ffffff',
            chatbot_launcher_bg: 'linear-gradient(135deg, #f472b6, #ec4899)',
            chatbot_launcher_text: '#ffffff',
            chatbot_send_bg: 'linear-gradient(135deg, #a855f7, #ec4899)',
            chatbot_send_text: '#ffffff',
            chatbot_frame_bg: '#fff7ed',
            chatbot_messages_bg: '#fdf2f8',
            chatbot_input_bg: '#ffffff',
            chatbot_input_text: '#4b1b3a',
            chatbot_input_border: '#f9a8d4',
            chatbot_input_area_bg: 'rgba(255, 255, 255, 0.95)',
            chatbot_input_area_padding_x: '14',
            chatbot_input_area_padding_y: '12',
            chatbot_input_area_blur: '6',
            chatbot_bubble_bot_bg: '#ffffff',
            chatbot_bubble_bot_text: '#4b1b3a',
            chatbot_bubble_bot_border: '#fbcfe8',
            chatbot_bubble_user_bg: 'linear-gradient(135deg, #f472b6, #a855f7)',
            chatbot_bubble_user_text: '#ffffff',
            chatbot_bubble_user_border: 'transparent',
            chatbot_bubble_radius: '16',
            chatbot_bubble_padding_x: '14',
            chatbot_bubble_padding_y: '10',
            chatbot_bubble_font_size: '14',
            chatbot_bubble_line_height: '1.45',
            chatbot_bubble_max_width: '80',
            chatbot_message_font_family: '\"Plus Jakarta Sans\", \"Segoe UI\", sans-serif'
        },
        futuristic: {
            chatbot_header_bg: 'linear-gradient(135deg, #0b1020, #111827)',
            chatbot_header_text: '#e2e8f0',
            chatbot_launcher_bg: 'linear-gradient(135deg, #06b6d4, #22d3ee)',
            chatbot_launcher_text: '#0b1020',
            chatbot_send_bg: 'linear-gradient(135deg, #22d3ee, #38bdf8)',
            chatbot_send_text: '#0b1020',
            chatbot_frame_bg: '#0b1020',
            chatbot_messages_bg: 'rgba(2, 6, 23, 0.92)',
            chatbot_input_bg: '#111827',
            chatbot_input_text: '#e2e8f0',
            chatbot_input_border: '#1f2937',
            chatbot_input_area_bg: 'rgba(15, 23, 42, 0.85)',
            chatbot_input_area_padding_x: '14',
            chatbot_input_area_padding_y: '12',
            chatbot_input_area_blur: '10',
            chatbot_bubble_bot_bg: '#111827',
            chatbot_bubble_bot_text: '#e2e8f0',
            chatbot_bubble_bot_border: '#1f2937',
            chatbot_bubble_user_bg: 'linear-gradient(135deg, #22d3ee, #38bdf8)',
            chatbot_bubble_user_text: '#0b1020',
            chatbot_bubble_user_border: 'transparent',
            chatbot_bubble_radius: '14',
            chatbot_bubble_padding_x: '14',
            chatbot_bubble_padding_y: '10',
            chatbot_bubble_font_size: '14',
            chatbot_bubble_line_height: '1.5',
            chatbot_bubble_max_width: '80',
            chatbot_message_font_family: '\"Space Grotesk\", \"Segoe UI\", sans-serif'
        }
    };

    function setFieldValue(fieldId, value){
        var field = document.getElementById(fieldId);
        if(!field){ return; }
        field.value = value;
        if(field.classList.contains('js-chatbot-color-text')){
            syncPickerWithText(field);
        }
    }

    function applyThemePreset(name){
        var theme = chatbotThemes[name];
        if(!theme){ return; }
        applyingTheme = true;
        Object.keys(theme).forEach(function(fieldId){
            setFieldValue(fieldId, theme[fieldId]);
        });
        applyingTheme = false;
    }

    function syncThemeVisibility(){
        if(!themeSelect){ return; }
        var isCustom = themeSelect.value === 'custom';
        customSettings.forEach(function(section){
            section.classList.toggle('is-hidden', !isCustom);
        });
        themeHints.forEach(function(hint){
            hint.style.display = isCustom ? 'none' : 'block';
        });
        if(isCustom){
            if(advancedToggle){
                setAdvancedMode(advancedToggle.checked);
            }
        } else {
            setAdvancedMode(false);
        }
    }

    if(themeSelect){
        themeSelect.addEventListener('change', function(){
            if(themeSelect.value && themeSelect.value !== 'custom'){
                applyThemePreset(themeSelect.value);
            }
            syncThemeVisibility();
        });

        var settingsForm = themeSelect.closest('form');
        if(settingsForm){
            settingsForm.addEventListener('input', function(event){
                if(applyingTheme || !themeSelect){ return; }
                var target = event.target;
                if(!target || !target.name || target.id === 'chatbot_theme_preset'){ return; }
                if(target.name.indexOf('chatbot_') === 0 && themeSelect.value !== 'custom'){
                    themeSelect.value = 'custom';
                    syncThemeVisibility();
                }
            });
            settingsForm.addEventListener('change', function(event){
                if(applyingTheme || !themeSelect){ return; }
                var target = event.target;
                if(!target || !target.name || target.id === 'chatbot_theme_preset'){ return; }
                if(target.name.indexOf('chatbot_') === 0 && themeSelect.value !== 'custom'){
                    themeSelect.value = 'custom';
                    syncThemeVisibility();
                }
            });
        }
        syncThemeVisibility();
    }
})();
</script>
{/literal}

{include file="admin/footer.tpl"}
