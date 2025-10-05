{include file="admin/header.tpl"}

{assign var=is_enabled value=($config.chatbot_enabled eq '1')}

{literal}
<style>
    .chatbot-settings-wrapper { position: relative; }
    .chatbot-summary { background: linear-gradient(135deg, #f0f4ff 0%, #ffffff 100%); border: 1px solid rgba(99,102,241,.15); border-radius: 14px; padding: 20px 24px; margin-bottom: 24px; box-shadow: 0 10px 30px rgba(15,23,42,.05); }
    .chatbot-summary__top { display: flex; flex-wrap: wrap; justify-content: space-between; gap: 16px; align-items: center; }
    .chatbot-summary__label { font-size: 12px; text-transform: uppercase; letter-spacing: .08em; color: #64748b; display: block; margin-bottom: 6px; font-weight: 600; }
    .chatbot-summary__endpoint code { display: inline-block; padding: 4px 8px; border-radius: 8px; background: rgba(15,23,42,.06); color: #0f172a; }
    .chatbot-summary__description { margin: 12px 0 0; color: #475569; font-size: 13px; line-height: 1.6; max-width: 720px; }
    .chatbot-status { display: inline-flex; align-items: center; gap: 6px; padding: 4px 12px; border-radius: 999px; font-weight: 600; font-size: 12px; }
    .chatbot-status--on { background: rgba(34,197,94,.12); color: #15803d; }
    .chatbot-status--off { background: rgba(248,113,113,.12); color: #e11d48; }

    .chatbot-card { background: #ffffff; border-radius: 12px; border: 1px solid rgba(100,116,139,.18); padding: 20px 24px; margin-bottom: 24px; box-shadow: 0 12px 30px rgba(15,23,42,.04); }
    .chatbot-card__title { font-size: 16px; font-weight: 600; color: #111827; margin-bottom: 6px; }
    .chatbot-card__subtitle { font-size: 13px; color: #6b7280; margin-bottom: 16px; }

    .chatbot-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 18px; }
    .chatbot-grid textarea.form-control { min-height: 120px; }
    .chatbot-helper { font-size: 12px; color: #64748b; margin-top: 6px; display: block; line-height: 1.4; }
    .chatbot-multi { min-height: 220px; }

    .chatbot-auth-block { display: none; border-top: 1px dashed rgba(148,163,184,.5); padding-top: 18px; margin-top: 18px; }
    .chatbot-auth-block.is-active { display: block; }
    .chatbot-auth-title { font-size: 14px; font-weight: 600; color: #475569; margin-bottom: 12px; }

    .chatbot-form-actions { display: flex; justify-content: flex-end; align-items: center; margin-top: 12px; }

    @media (max-width: 640px) {
        .chatbot-summary { padding: 16px; }
        .chatbot-card { padding: 16px; }
        .chatbot-grid { gap: 12px; }
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
                                <span class="chatbot-summary__label">Endpoint</span>
                                {if $config.chatbot_endpoint|trim neq ''}
                                    <code>{$config.chatbot_endpoint|escape}</code>
                                {else}
                                    <span class="text-muted">Not configured</span>
                                {/if}
                            </div>
                        </div>
                        <p class="chatbot-summary__description">
                            Kelola status chatbot, pengalaman pengguna, histori percakapan, serta metode autentikasi yang digunakan. Perubahan akan otomatis disuntikkan ke footer yang dipilih setelah Anda menyimpannya.
                        </p>
                    </div>

                    <ul class="nav nav-tabs" role="tablist">
                        {foreach $chatbot_sections as $key => $anchor}
                            <li class="nav-item"><a class="nav-link {if $key eq $chatbot_active_section}active{/if}" href="{getUrl('plugin/ai_chatbot_settings/')}{$key}">{$key|replace:'-':' '|ucwords}</a></li>
                        {/foreach}
                    </ul>

                    <form method="post" action="{getUrl('plugin/ai_chatbot_settings/')}{$chatbot_active_section}" class="mt-4">
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
                                                <label for="chatbot_endpoint">AI Endpoint URL</label>
                                                <input type="url" id="chatbot_endpoint" name="chatbot_endpoint" class="form-control" value="{$config.chatbot_endpoint|escape}" placeholder="https://your.ai.endpoint/chat">
                                                <span class="chatbot-helper">URL REST API yang menerima permintaan percakapan.</span>
                                            </div>
                                            <div class="form-group">
                                                <label for="chatbot_request_timeout">Request Timeout (detik)</label>
                                                <input type="number" min="5" max="600" id="chatbot_request_timeout" name="chatbot_request_timeout" class="form-control" value="{$config.chatbot_request_timeout|escape}">
                                                <span class="chatbot-helper">Berapa lama sistem menunggu respons sebelum menampilkan pesan gagal.</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Penempatan Pada Footer</h3>
                                        <p class="chatbot-card__subtitle">Pilih footer mana saja yang akan memuat tombol chatbot otomatis.</p>
                                        {if $chatbot_footer_options|@count}
                                            <div class="form-group">
                                                <label for="chatbot_footer_targets">Halaman yang disuntikkan</label>
                                                <select id="chatbot_footer_targets" name="chatbot_footer_targets[]" class="form-control chatbot-multi" multiple size="10">
                                                    {foreach $chatbot_footer_options as $option}
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

                                {if $chatbot_active_section eq 'conversation-history'}
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

                                {if $chatbot_active_section eq 'authentication'}
                                    <div class="chatbot-card">
                                        <h3 class="chatbot-card__title">Metode Autentikasi</h3>
                                        <p class="chatbot-card__subtitle">Pilih mekanisme autentikasi yang diperlukan oleh endpoint AI Anda.</p>
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
                                    </div>
                                {/if}

                            </div>
                        </div>
                        <div class="chatbot-form-actions">
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
})();
</script>
{/literal}

{include file="admin/footer.tpl"}
