<?php
register_menu("AI Chatbot", true, "ai_chatbot_settings", 'SETTINGS', 'fa fa-android');
/**
 * AI Chatbot Plugin for PHPNuxBill with enhanced feature set.
 * Consolidated and refactored for clarity and consistency.
 */

function ai_chatbot_settings()
{
    global $routes;

    $sub_route = $routes[2] ?? 'general';
    if ($sub_route === 'bootstrap') {
        ai_chatbot_bootstrap();
        return;
    }

    if ($sub_route === 'proxy') {
        ai_chatbot_run_proxy();
        return;
    }

    if ($sub_route === 'page') {
        $sub_route = 'general';
    }

    $sections = ai_chatbot_sections();
    if (!isset($sections[$sub_route])) {
        $sub_route = 'general';
    }

    ai_chatbot_show_settings_page($sub_route);
}


function ai_chatbot_defaults()
{
    return [
        'chatbot_enabled' => '0',
        'chatbot_endpoint' => '',
        'chatbot_title' => 'AI Chat',
        'chatbot_button_label' => '',
        'chatbot_button_side' => 'right',
        'chatbot_avatar_url' => '',
        'chatbot_auth_type' => 'none',
        'chatbot_basic_user' => '',
        'chatbot_basic_pass' => '',
        'chatbot_header_key' => 'X-API-Key',
        'chatbot_header_value' => '',
        'chatbot_as_bearer' => 'no',
        'chatbot_jwt_token' => '',
        'chatbot_jwt_secret' => '',
        'chatbot_jwt_iss' => '',
        'chatbot_jwt_aud' => '',
        'chatbot_jwt_sub' => '',
        'chatbot_jwt_ttl' => '300',
        'chatbot_history_mode' => 'ttl',
        'chatbot_history_ttl' => '360',
        'chatbot_history_max_messages' => '50',
        'chatbot_request_timeout' => '30',
        'chatbot_typing_mode' => 'off',
        'chatbot_typing_wpm' => '600',
        'chatbot_user_input_max_chars' => '1000',
        'chatbot_frame_mode' => 'fixed',
        'chatbot_frame_width' => '340',
        'chatbot_frame_height' => '460',
        'chatbot_welcome_enabled' => '0',
        'chatbot_welcome_message' => '',
        'chatbot_footer_targets' => 'ui/ui/customer/footer.tpl,ui/ui/customer/footer-public.tpl,ui/ui/admin/footer.tpl',
    ];
}

function ai_chatbot_setting_keys()
{
    return array_keys(ai_chatbot_defaults());
}

function ai_chatbot_sections()
{
    return [
        'general' => 'general-settings',
        'chat-experience' => 'experience-settings',
        'conversation-history' => 'history-settings',
    ];
}


function ai_chatbot_section_field_map()
{
    return [
        'general' => [
            'chatbot_enabled',
            'chatbot_endpoint',
            'chatbot_footer_targets',
            'chatbot_request_timeout',
            'chatbot_auth_type',
            'chatbot_header_key',
            'chatbot_header_value',
            'chatbot_as_bearer',
            'chatbot_basic_user',
            'chatbot_basic_pass',
            'chatbot_jwt_token',
            'chatbot_jwt_secret',
            'chatbot_jwt_iss',
            'chatbot_jwt_aud',
            'chatbot_jwt_sub',
            'chatbot_jwt_ttl',
        ],
        'chat-experience' => [
            'chatbot_title',
            'chatbot_button_label',
            'chatbot_button_side',
            'chatbot_avatar_url',
            'chatbot_welcome_enabled',
            'chatbot_welcome_message',
            'chatbot_typing_mode',
            'chatbot_typing_wpm',
            'chatbot_user_input_max_chars',
            'chatbot_frame_mode',
            'chatbot_frame_width',
            'chatbot_frame_height',
        ],
        'conversation-history' => [
            'chatbot_history_mode',
            'chatbot_history_ttl',
            'chatbot_history_max_messages',
        ],
    ];
}



if (function_exists('register_hook')) {
    register_hook('footer_scripts', 'ai_chatbot_render');
}

if (!defined('AI_CHATBOT_SNIPPET_VERSION')) {

    define('AI_CHATBOT_SNIPPET_VERSION', 2);

}

if (!defined('AI_CHATBOT_SNIPPET_START')) {
    define('AI_CHATBOT_SNIPPET_START', '<!-- AI_CHATBOT_PLUGIN_START -->');
    define('AI_CHATBOT_SNIPPET_END', '<!-- AI_CHATBOT_PLUGIN_END -->');
}


function ai_chatbot_render()
{
    // Footer injection handled via ai_chatbot_sync_footer_includes().
}



function ai_chatbot_normalise_timeout($value, $fallback = 30)
{
    if (is_string($value)) {
        $value = trim($value);
    }
    $candidate = is_numeric($value) ? (int) $value : 0;

    if ($candidate <= 0) {
        if (is_string($fallback)) {
            $fallback = trim($fallback);
        }
        $fallback_candidate = is_numeric($fallback) ? (int) $fallback : 0;
        if ($fallback_candidate <= 0) {
            $fallback_candidate = 30;
        }
        $candidate = $fallback_candidate;
    }

    if ($candidate < 5) {
        $candidate = 5;
    } elseif ($candidate > 600) {
        $candidate = 600;
    }

    return (string) $candidate;
}


function ai_chatbot_normalize_target_path($value)
{
    if (!is_string($value)) {
        $value = (string) $value;
    }

    $value = trim($value);
    if ($value === '') {
        return '';
    }

    if (preg_match('#^[a-z][a-z0-9+.-]*://#i', $value)) {
        return '';
    }

    $value = str_replace('\\', '/', $value);
    $value = preg_replace('#/{2,}#', '/', $value);
    $value = ltrim($value, '/');

    if ($value === '') {
        return '';
    }

    $parts = array_filter(explode('/', $value), static function ($part) {
        return $part !== '';
    });

    $normalized_parts = [];
    foreach ($parts as $part) {
        if ($part === '.') {
            continue;
        }
        if ($part === '..' || strpos($part, ':') !== false) {
            return '';
        }
        $normalized_parts[] = $part;
    }

    if (empty($normalized_parts)) {
        return '';
    }

    return implode('/', $normalized_parts);
}

function ai_chatbot_normalize_footer_targets($value)
{
    if (!is_string($value)) {
        return '';
    }

    $targets = array_map('ai_chatbot_normalize_target_path', explode(',', $value));
    $filtered_targets = array_filter($targets, static function ($path) {
        return $path !== '';
    });
    $unique_targets = array_values(array_unique($filtered_targets));

    return implode(',', $unique_targets);
}

function ai_chatbot_parse_footer_targets($value)
{
    $normalized = ai_chatbot_normalize_footer_targets($value);
    return ($normalized === '') ? [] : explode(',', $normalized);
}

function ai_chatbot_discover_footer_templates()
{
    global $root_path;

    $root = rtrim($root_path ?? '', DIRECTORY_SEPARATOR);
    if ($root === '') {
        return [];
    }

    $patterns = [
        $root . DIRECTORY_SEPARATOR . 'ui' . DIRECTORY_SEPARATOR . 'ui' . DIRECTORY_SEPARATOR . '*' . DIRECTORY_SEPARATOR . 'footer*.tpl',
        $root . DIRECTORY_SEPARATOR . 'ui' . DIRECTORY_SEPARATOR . 'ui_custom' . DIRECTORY_SEPARATOR . '*' . DIRECTORY_SEPARATOR . 'footer*.tpl',
    ];

    $results = [];
    foreach ($patterns as $pattern) {
        foreach (glob($pattern) as $path) {
            if (!is_file($path)) {
                continue;
            }

            $relative = str_replace('\\', '/', substr($path, strlen($root) + 1));
            $results[] = $relative;
        }
    }

    sort($results);

    return array_values(array_unique($results));
}

function ai_chatbot_pretty_footer_label($relative)
{
    $normalized = ai_chatbot_normalize_target_path($relative);
    if ($normalized === '') {
        return $relative;
    }

    $parts = explode('/', $normalized);
    $area = $parts[2] ?? '';
    $file = end($parts) ?: $normalized;

    $area_label = $area !== '' ? ucwords(str_replace(['-', '_'], ' ', $area)) : 'General';
    $file_label = ucwords(str_replace(['-', '_'], ' ', preg_replace('/\.tpl$/', '', $file)));

    $scope = strncmp($normalized, 'ui/ui_custom/', 12) === 0 ? 'Custom' : 'Default';

    return $area_label . ' - ' . $file_label . ' (' . $scope . ')';
}

function ai_chatbot_footer_options()
{
    $options = [];
    $discovered = ai_chatbot_discover_footer_templates();

    if (empty($discovered)) {
        $fallback = [
            'ui/ui/customer/footer.tpl' => 'Customer Area Footer (Default)',
            'ui/ui/customer/footer-public.tpl' => 'Public Pages Footer (Default)',
            'ui/ui/admin/footer.tpl' => 'Admin Area Footer (Default)',
        ];

        foreach ($fallback as $relative => $label) {
            $options[$relative] = [
                'label' => $label,
                'path' => $relative,
                'selected' => false,
                'exists' => false,
            ];
        }

        return $options;
    }

    foreach ($discovered as $relative) {
        $options[$relative] = [
            'label' => ai_chatbot_pretty_footer_label($relative),
            'path' => $relative,
            'selected' => false,
            'exists' => true,
        ];
    }

    return $options;
}

function ai_chatbot_snippet_body()
{
    return '{include file="[plugin]ai_chatbot.tpl"}';
}

function ai_chatbot_injection_snippet_block()
{
    return AI_CHATBOT_SNIPPET_START . PHP_EOL
        . ai_chatbot_snippet_body() . PHP_EOL
        . AI_CHATBOT_SNIPPET_END;
}

function ai_chatbot_absolute_path($relative)
{
    global $root_path;

    $normalized = ai_chatbot_normalize_target_path($relative);
    if ($normalized === '' || !isset($root_path)) {
        return null;
    }

    $base = rtrim($root_path, DIRECTORY_SEPARATOR);
    if ($base === '') {
        return null;
    }

    return $base . DIRECTORY_SEPARATOR . str_replace('/', DIRECTORY_SEPARATOR, $normalized);
}

function ai_chatbot_insert_snippet($contents)
{
    $snippet = ai_chatbot_injection_snippet_block();
    $insertion = PHP_EOL . $snippet . PHP_EOL;

    $pos = stripos($contents, '</body>');
    if ($pos === false) {
        return rtrim($contents) . $insertion;
    }

    return substr($contents, 0, $pos) . $insertion . substr($contents, $pos);
}

function ai_chatbot_remove_snippet($contents)
{
    $pattern = '/' . preg_quote(AI_CHATBOT_SNIPPET_START, '/') . '.*?' . preg_quote(AI_CHATBOT_SNIPPET_END, '/') . '\s*/is';
    $updated = preg_replace($pattern, PHP_EOL, $contents);

    return $updated === null ? $contents : $updated;
}

function ai_chatbot_refresh_snippet($contents)
{
    $pattern = '/' . preg_quote(AI_CHATBOT_SNIPPET_START, '/') . '.*?' . preg_quote(AI_CHATBOT_SNIPPET_END, '/') . '/is';
    $replacement = ai_chatbot_injection_snippet_block();

    $updated = preg_replace($pattern, $replacement, $contents);

    return $updated === null ? $contents : $updated;
}

function ai_chatbot_footer_contains_marker($relative)
{
    $absolute = ai_chatbot_absolute_path($relative);
    if (!$absolute || !is_file($absolute)) {
        return false;
    }

    $contents = @file_get_contents($absolute);
    if ($contents === false) {
        return false;
    }

    return strpos($contents, AI_CHATBOT_SNIPPET_START) !== false
        && strpos($contents, AI_CHATBOT_SNIPPET_END) !== false;
}

function ai_chatbot_all_known_footer_targets(array $selected_targets)
{
    $known = ai_chatbot_discover_footer_templates();

    foreach ($selected_targets as $target) {
        $normalized = ai_chatbot_normalize_target_path($target);
        if ($normalized === '') {
            continue;
        }

        $known[] = $normalized;

        if (strpos($normalized, 'ui/ui/') === 0) {
            $custom = ai_chatbot_normalize_target_path(str_replace('ui/ui/', 'ui/ui_custom/', $normalized));
            if ($custom !== '') {
                $known[] = $custom;
            }
        }
    }

    $known = array_filter(array_map('ai_chatbot_normalize_target_path', $known), static function ($path) {
        return $path !== '';
    });

    $known = array_values(array_unique($known));
    sort($known);

    return $known;
}

function ai_chatbot_footer_state_path()
{
    $dir = ai_chatbot_cache_dir();
    if (!$dir) {
        return null;
    }

    return $dir . DIRECTORY_SEPARATOR . 'footer_state.json';
}

function ai_chatbot_load_footer_state()
{
    $path = ai_chatbot_footer_state_path();
    if (!$path || !is_file($path)) {
        return null;
    }

    $raw = @file_get_contents($path);
    if ($raw === false) {
        return null;
    }

    $decoded = json_decode($raw, true);
    if (!is_array($decoded)) {
        return null;
    }

    $enabled = !empty($decoded['enabled']);
    $targets = isset($decoded['targets']) && is_array($decoded['targets']) ? $decoded['targets'] : [];
    $version = isset($decoded['version']) ? (int) $decoded['version'] : 1;

    sort($targets);

    return [
        'enabled' => $enabled,
        'targets' => $targets,
        'version' => $version,
    ];
}

function ai_chatbot_store_footer_state($enabled, array $targets)
{
    $path = ai_chatbot_footer_state_path();
    if (!$path) {
        return;
    }

    sort($targets);

    $payload = json_encode([
        'enabled' => $enabled ? 1 : 0,
        'targets' => array_values($targets),
        'version' => AI_CHATBOT_SNIPPET_VERSION,
        'updated_at' => time(),
    ]);

    if ($payload === false) {
        return;
    }

    @file_put_contents($path, $payload, LOCK_EX);
}

function ai_chatbot_sync_footer_includes($is_enabled, array $selected_targets)
{
    $normalized_targets = array_map('ai_chatbot_normalize_target_path', $selected_targets);
    $normalized_targets = array_filter($normalized_targets, static function ($path) {
        return $path !== '';
    });
    $normalized_targets = array_values(array_unique($normalized_targets));
    sort($normalized_targets);

    $state = ai_chatbot_load_footer_state();
    $state_matches = $state
        && $state['enabled'] === (bool) $is_enabled
        && $state['targets'] === $normalized_targets
        && (($state['version'] ?? 0) === AI_CHATBOT_SNIPPET_VERSION);

    if ($state_matches) {
        if ($is_enabled && !empty($normalized_targets)) {
            $first = $normalized_targets[0];
            if (ai_chatbot_footer_contains_marker($first)) {
                return;
            }
        } else {
            return;
        }
    }

    $desired_map = [];
    if ($is_enabled) {
        foreach ($normalized_targets as $target) {
            $desired_map[$target] = true;

            if (strpos($target, 'ui/ui/') === 0) {
                $custom = ai_chatbot_normalize_target_path(str_replace('ui/ui/', 'ui/ui_custom/', $target));
                if ($custom !== '') {
                    $desired_map[$custom] = true;
                }
            }
        }
    }

    $candidates = ai_chatbot_all_known_footer_targets($normalized_targets);
    $changed = false;

    foreach ($candidates as $relative) {
        $absolute = ai_chatbot_absolute_path($relative);
        if (!$absolute || !is_file($absolute) || !is_readable($absolute)) {
            continue;
        }

        $contents = @file_get_contents($absolute);
        if ($contents === false) {
            continue;
        }

        $has_snippet = strpos($contents, AI_CHATBOT_SNIPPET_START) !== false;
        $needs_snippet = isset($desired_map[$relative]);

        $updated = $contents;

        if ($needs_snippet) {
            $updated = $has_snippet ? ai_chatbot_refresh_snippet($contents) : ai_chatbot_insert_snippet($contents);
        } elseif ($has_snippet) {
            $updated = ai_chatbot_remove_snippet($contents);
        } else {
            continue;
        }

        if ($updated !== $contents) {
            if (@file_put_contents($absolute, $updated, LOCK_EX) !== false) {
                $changed = true;
            }
        }
    }

    if ($changed || !$state_matches) {
        ai_chatbot_store_footer_state((bool) $is_enabled, $normalized_targets);
    }
}

function ai_chatbot_limit_length($value, $max)
{
    if (!is_string($value)) {
        $value = (string) $value;
    }
    $value = trim(strip_tags($value));
    if ($value === '') {
        return '';
    }

    if (function_exists('mb_substr')) {
        return mb_substr($value, 0, $max, 'UTF-8');
    }

    return substr($value, 0, $max);
}

function ai_chatbot_base64url_encode($data)
{
    return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
}

function ai_chatbot_make_jwt(array $claims, $secret)
{
    $header = ['alg' => 'HS256', 'typ' => 'JWT'];
    $segments = [
        ai_chatbot_base64url_encode(json_encode($header, JSON_UNESCAPED_SLASHES)),
        ai_chatbot_base64url_encode(json_encode($claims, JSON_UNESCAPED_SLASHES)),
    ];
    $signing_input = implode('.', $segments);
    $signature = hash_hmac('sha256', $signing_input, $secret, true);
    $segments[] = ai_chatbot_base64url_encode($signature);

    return implode('.', $segments);
}


if (!defined('AI_CHATBOT_PROXY_TTL')) {
    define('AI_CHATBOT_PROXY_TTL', 1800);
}
if (!defined('AI_CHATBOT_CONFIG_TTL')) {
    define('AI_CHATBOT_CONFIG_TTL', 86400);
}

function ai_chatbot_with_retry_notice($message, $fallback = 'Terjadi kesalahan.')
{
    $base = is_string($message) ? trim($message) : '';
    if ($base === '') {
        $base = is_string($fallback) && $fallback !== '' ? trim($fallback) : 'Terjadi kesalahan.';
    }
    $base = rtrim($base, " 	
\0\x0B.");
    return $base . '. Silakan kirim ulang permintaan Anda.';
}

function ai_chatbot_cache_dir()
{
    global $CACHE_PATH;

    $base = $CACHE_PATH ?? null;
    if (!$base) {
        return null;
    }

    $dir = rtrim($base, DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR . 'ai_chatbot';
    if (!is_dir($dir)) {
        if (!@mkdir($dir, 0775, true) && !is_dir($dir)) {
            return null;
        }
    }

    return $dir;
}

function ai_chatbot_cache_path($config_key)
{
    $dir = ai_chatbot_cache_dir();
    if (!$dir) {
        return null;
    }

    return $dir . DIRECTORY_SEPARATOR . $config_key . '.json';
}

function ai_chatbot_ensure_session()
{
    if (session_status() === PHP_SESSION_NONE) {
        @session_start();
    }
}

function ai_chatbot_store_config_cache($config_key, array $config)
{
    $path = ai_chatbot_cache_path($config_key);
    if (!$path) {
        return;
    }

    $payload = json_encode([
        'config' => $config,
        'expires_at' => time() + AI_CHATBOT_CONFIG_TTL,
    ]);

    if ($payload === false) {
        return;
    }

    @file_put_contents($path, $payload);
}

function ai_chatbot_load_config_cache($config_key)
{
    $path = ai_chatbot_cache_path($config_key);
    if (!$path || !is_file($path)) {
        return null;
    }

    $raw = @file_get_contents($path);
    if ($raw === false) {
        return null;
    }

    $data = json_decode($raw, true);
    if (!is_array($data) || !isset($data['config'])) {
        return null;
    }

    if (isset($data['expires_at']) && $data['expires_at'] < time()) {
        @unlink($path);
        return null;
    }

    return $data['config'];
}
if (!defined('AI_CHATBOT_AUTOSYNC_REGISTERED')) {
    define('AI_CHATBOT_AUTOSYNC_REGISTERED', true);

    register_shutdown_function(static function () {
        if (!isset($GLOBALS['config']) || !is_array($GLOBALS['config'])) {
            return;
        }

        $settings = ai_chatbot_load_config();
        $targets = ai_chatbot_parse_footer_targets($settings['chatbot_footer_targets'] ?? '');
        ai_chatbot_sync_footer_includes(($settings['chatbot_enabled'] ?? '0') === '1', $targets);
    });
}


function ai_chatbot_store_proxy_context(array $config, $existing_proxy_id = null, $existing_config_key = null)
{
    ai_chatbot_ensure_session();

    if (!isset($_SESSION['ai_chatbot_proxies']) || !is_array($_SESSION['ai_chatbot_proxies'])) {
        $_SESSION['ai_chatbot_proxies'] = [];
    }

    $config_key = $existing_config_key ?: hash('sha256', json_encode($config, JSON_UNESCAPED_SLASHES));
    $proxy_id = $existing_proxy_id ?: bin2hex(random_bytes(16));

    $_SESSION['ai_chatbot_proxies'][$proxy_id] = [
        'config' => $config,
        'config_key' => $config_key,
        'expires_at' => time() + AI_CHATBOT_PROXY_TTL,
    ];

    ai_chatbot_store_config_cache($config_key, $config);

    return [$proxy_id, $config_key];
}

function ai_chatbot_lookup_proxy_entry($proxy_id)
{
    ai_chatbot_ensure_session();

    if (
        !isset($_SESSION['ai_chatbot_proxies']) ||
        !is_array($_SESSION['ai_chatbot_proxies']) ||
        !isset($_SESSION['ai_chatbot_proxies'][$proxy_id])
    ) {
        return null;
    }

    $entry = $_SESSION['ai_chatbot_proxies'][$proxy_id];
    $expires_at = isset($entry['expires_at']) ? (int) $entry['expires_at'] : 0;

    if ($expires_at > 0 && $expires_at < time()) {
        unset($_SESSION['ai_chatbot_proxies'][$proxy_id]);
        return null;
    }

    $_SESSION['ai_chatbot_proxies'][$proxy_id]['expires_at'] = time() + AI_CHATBOT_PROXY_TTL;

    return $_SESSION['ai_chatbot_proxies'][$proxy_id];
}

function ai_chatbot_collect_proxy_config(array $settings)
{
    $endpoint = isset($settings['chatbot_endpoint']) ? (string) $settings['chatbot_endpoint'] : '';
    $auth_type = isset($settings['chatbot_auth_type']) ? strtolower((string) $settings['chatbot_auth_type']) : 'none';

    $auth = ['type' => in_array($auth_type, ['basic', 'header', 'jwt'], true) ? $auth_type : 'none'];

    switch ($auth['type']) {
        case 'basic':
            $auth['basic_user'] = $settings['chatbot_basic_user'] ?? '';
            $auth['basic_pass'] = $settings['chatbot_basic_pass'] ?? '';
            break;

        case 'header':
            $auth['header_key'] = $settings['chatbot_header_key'] ?? 'X-API-Key';
            $auth['header_value'] = $settings['chatbot_header_value'] ?? '';
            $auth['as_bearer'] = ($settings['chatbot_as_bearer'] ?? 'no') === 'yes';
            break;

        case 'jwt':
            $auth['jwt_token'] = $settings['chatbot_jwt_token'] ?? '';
            $auth['jwt_secret'] = $settings['chatbot_jwt_secret'] ?? '';
            $auth['jwt_iss'] = $settings['chatbot_jwt_iss'] ?? '';
            $auth['jwt_aud'] = $settings['chatbot_jwt_aud'] ?? '';
            $auth['jwt_sub'] = $settings['chatbot_jwt_sub'] ?? '';
            $auth['jwt_ttl'] = isset($settings['chatbot_jwt_ttl']) ? (int) $settings['chatbot_jwt_ttl'] : 300;
            if ($auth['jwt_ttl'] <= 0) {
                $auth['jwt_ttl'] = 300;
            }
            break;
    }

    return [
        'endpoint' => $endpoint,
        'auth' => $auth,
        'request_timeout' => (int) ai_chatbot_normalise_timeout($settings['chatbot_request_timeout'] ?? 30, 30),
        'user_input_max_chars' => isset($settings['chatbot_user_input_max_chars'])
            ? (int) $settings['chatbot_user_input_max_chars']
            : 1000,
    ];
}

function ai_chatbot_post_with_retry($url, array $headers, $body, $timeout, $max_attempts = 3, $base_delay_ms = 300, $max_delay_ms = 2000)
{
    $max_attempts = max(1, (int) $max_attempts);
    $base_delay_ms = max(0, (int) $base_delay_ms);
    $max_delay_ms = max($base_delay_ms, (int) $max_delay_ms);

    $attempt = 0;
    $delay = $base_delay_ms;
    $last_error = null;

    while ($attempt < $max_attempts) {
        $attempt++;

        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_POST => true,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HTTPHEADER => $headers,
            CURLOPT_POSTFIELDS => $body,
            CURLOPT_TIMEOUT => $timeout,
            CURLOPT_CONNECTTIMEOUT => min(15, $timeout),
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_FAILONERROR => false,
        ]);

        $response_body = curl_exec($ch);
        $errno = curl_errno($ch);
        $error_message = curl_error($ch);
        $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($errno === 0 && $response_body !== false) {
            return [
                'success' => true,
                'body' => $response_body,
                'http_code' => $http_code ?: 200,
                'attempts' => $attempt,
                'max_attempts' => $max_attempts,
            ];
        }

        $last_error = [
            'errno' => $errno,
            'message' => $error_message ?: curl_strerror($errno),
            'http_code' => $http_code ?? 0,
        ];

        $retryable_codes = [
            CURLE_OPERATION_TIMEOUTED,
            CURLE_COULDNT_RESOLVE_HOST,
            CURLE_COULDNT_CONNECT,
            CURLE_RECV_ERROR,
            CURLE_SEND_ERROR,
        ];
        if (defined('CURLE_GOT_NOTHING')) {
            $retryable_codes[] = CURLE_GOT_NOTHING;
        }

        $retryable = in_array($errno, $retryable_codes, true);

        if (!$retryable || $attempt >= $max_attempts) {
            break;
        }

        if ($delay > 0) {
            usleep($delay * 1000);
            $delay = min($delay * 2, $max_delay_ms);
        }
    }

    return [
        'success' => false,
        'error' => $last_error,
        'attempts' => $attempt ?: 1,
        'max_attempts' => $max_attempts,
    ];
}

function ai_chatbot_sanitize_setting($key, $value)
{
    if (is_array($value)) {
        if ($key === 'chatbot_footer_targets') {
            $value = implode(',', $value);
        } else {
            $value = '';
        }
    }
    $value = is_string($value) ? trim($value) : $value;

    switch ($key) {
        case 'chatbot_enabled':
        case 'chatbot_welcome_enabled':
            return (in_array(strtolower((string) $value), ['1', 'yes', 'true'], true)) ? '1' : '0';

        case 'chatbot_footer_targets':
            return ai_chatbot_normalize_footer_targets($value);

        case 'chatbot_endpoint':
        case 'chatbot_avatar_url':
            $sanitised = filter_var((string) $value, FILTER_SANITIZE_URL);
            return $sanitised ?: '';

        case 'chatbot_title':
        case 'chatbot_button_label':
            return ai_chatbot_limit_length($value, 120);

        case 'chatbot_button_side':
            $value = strtolower((string) $value);
            return in_array($value, ['left', 'right'], true) ? $value : 'right';

        case 'chatbot_auth_type':
            $value = strtolower((string) $value);
            return in_array($value, ['none', 'basic', 'header', 'jwt'], true) ? $value : 'none';

        case 'chatbot_basic_user':
            return ai_chatbot_limit_length($value, 120);

        case 'chatbot_basic_pass':
            return (string) $value;

        case 'chatbot_header_key':
            $value = preg_replace('/[^A-Za-z0-9\-]/', '', (string) $value);
            return $value !== '' ? $value : 'X-API-Key';

        case 'chatbot_header_value':
            return (string) $value;

        case 'chatbot_as_bearer':
            return (strtolower((string) $value) === 'yes') ? 'yes' : 'no';

        case 'chatbot_jwt_token':
        case 'chatbot_jwt_secret':
        case 'chatbot_jwt_iss':
        case 'chatbot_jwt_aud':
        case 'chatbot_jwt_sub':
            return ai_chatbot_limit_length($value, 255);

        case 'chatbot_jwt_ttl':
            $n = (int) $value;
            if ($n < 60) {
                $n = 300;
            } elseif ($n > 3600) {
                $n = 3600;
            }
            return (string) $n;

        case 'chatbot_history_mode':
            $value = strtolower((string) $value);
            return in_array($value, ['ttl', 'count'], true) ? $value : 'ttl';

        case 'chatbot_history_ttl':
            $n = (int) $value;
            if ($n <= 0) {
                $n = 360;
            }
            return (string) $n;

        case 'chatbot_history_max_messages':
            $n = (int) $value;
            if ($n <= 0) {
                $n = 50;
            } elseif ($n > 500) {
                $n = 500;
            }
            return (string) $n;

        case 'chatbot_typing_mode':
            $value = strtolower((string) $value);
            return in_array($value, ['off', 'wpm'], true) ? $value : 'off';

        case 'chatbot_typing_wpm':
            $n = (int) $value;
            if ($n <= 0) {
                $n = 300;
            } elseif ($n > 900) {
                $n = 900;
            }
            return (string) $n;

        case 'chatbot_request_timeout':
            return ai_chatbot_normalise_timeout($value, 30);

        case 'chatbot_user_input_max_chars':
            $n = (int) $value;
            if ($n < 100) {
                $n = 100;
            } elseif ($n > 4000) {
                $n = 4000;
            }
            return (string) $n;

        case 'chatbot_frame_mode':
            $value = strtolower((string) $value);
            return in_array($value, ['fixed', 'auto'], true) ? $value : 'fixed';

        case 'chatbot_frame_width':
            $n = (int) $value;
            if ($n < 280) {
                $n = 280;
            } elseif ($n > 640) {
                $n = 640;
            }
            return (string) $n;

        case 'chatbot_frame_height':
            $n = (int) $value;
            if ($n < 320) {
                $n = 320;
            } elseif ($n > 800) {
                $n = 800;
            }
            return (string) $n;

        case 'chatbot_welcome_message':
            return ai_chatbot_limit_length($value, 1000);

        default:
            return is_string($value) ? $value : (string) $value;
    }
}

function ai_chatbot_upsert_setting($key, $value)
{
    $record = ORM::for_table('tbl_appconfig')->where('setting', $key)->find_one();
    if (!$record) {
        $record = ORM::for_table('tbl_appconfig')->create();
        $record->setting = $key;
    }
    $record->value = $value;
    $record->save();
}

function ai_chatbot_load_config()
{
    global $config;
    $defaults = ai_chatbot_defaults();
    $settings = [];

    foreach ($defaults as $key => $default) {
        $raw = $config[$key] ?? $default;
        $settings[$key] = ai_chatbot_sanitize_setting($key, $raw);
    }

    return $settings;
}

function ai_chatbot_show_settings_page($active_section = 'general')
{
    global $ui, $config;

    _admin();

    $sections = ai_chatbot_sections();
    if (!isset($sections[$active_section])) {
        $active_section = 'general';
    }

    $ui->assign('_title', 'AI Chatbot Settings');
    $ui->assign('_system_menu', 'settings');
    $ui->assign('_admin', Admin::_info());
    $ui->assign('chatbot_sections', $sections);
    $ui->assign('chatbot_active_section', $active_section);
    $ui->assign('chatbot_active_anchor', $sections[$active_section]);

    $current_config = ai_chatbot_load_config();
    $keys = ai_chatbot_setting_keys();
    $section_map = ai_chatbot_section_field_map();
    $section_keys = $section_map[$active_section] ?? $keys;

    if (_post('save')) {
        $csrf_enabled = class_exists('Csrf') && ($config['csrf_enabled'] ?? 'yes') === 'yes';
        if ($csrf_enabled) {
            $csrf_token = _post('csrf_token');
            if (!Csrf::check($csrf_token)) {
                _msglog('e', Lang::T('Invalid or Expired CSRF Token'));
                Csrf::generateAndStoreToken();
                r2(getUrl('plugin/ai_chatbot_settings/' . $active_section));
            }
            Csrf::generateAndStoreToken();
        }

        $post_data = $_POST;

        if ($active_section === 'general') {
            if (isset($post_data['chatbot_footer_targets']) && is_array($post_data['chatbot_footer_targets'])) {
                $post_data['chatbot_footer_targets'] = implode(',', $post_data['chatbot_footer_targets']);
            } else {
                $post_data['chatbot_footer_targets'] = '';
            }
        } elseif (isset($post_data['chatbot_footer_targets']) && is_array($post_data['chatbot_footer_targets'])) {
            $post_data['chatbot_footer_targets'] = implode(',', $post_data['chatbot_footer_targets']);
        }

        $updated_keys = [];

        foreach ($section_keys as $key) {
            if ($key === 'chatbot_footer_targets') {
                if (!array_key_exists('chatbot_footer_targets', $post_data)) {
                    continue;
                }
                $raw_value = $post_data['chatbot_footer_targets'];
            } else {
                if (!array_key_exists($key, $post_data)) {
                    continue;
                }
                $raw_value = $post_data[$key];
            }

            $sanitised = ai_chatbot_sanitize_setting($key, $raw_value);
            ai_chatbot_upsert_setting($key, $sanitised);
            $config[$key] = $sanitised;
            $current_config[$key] = $sanitised;
            $updated_keys[] = $key;
        }

        if (!empty($updated_keys)) {
            $selected_targets = ai_chatbot_parse_footer_targets($current_config['chatbot_footer_targets'] ?? '');
            ai_chatbot_sync_footer_includes(($current_config['chatbot_enabled'] ?? '0') === '1', $selected_targets);
            _msglog('s', 'Settings saved successfully');
        } else {
            _msglog('e', 'No settings were updated.');
        }

        r2(getUrl('plugin/ai_chatbot_settings/' . $active_section));
    }

    $footer_options = ai_chatbot_footer_options();
    $footer_selected = ai_chatbot_parse_footer_targets($current_config['chatbot_footer_targets'] ?? '');

    ai_chatbot_sync_footer_includes(($current_config['chatbot_enabled'] ?? '0') === '1', $footer_selected);

    foreach ($footer_options as $option_key => &$option) {
        $option_path = $option['path'] ?? $option_key;
        $option_path = ai_chatbot_normalize_target_path($option_path);
        $option['path'] = $option_path;
        $option['selected'] = in_array($option_path, $footer_selected, true);
    }
    unset($option);

    $footer_options = array_values($footer_options);

    $ui->assign('config', $current_config);
    if (class_exists('Csrf') && ($config['csrf_enabled'] ?? 'yes') === 'yes') {
        $ui->assign('csrf_token', Csrf::generateAndStoreToken());
    }
    $ui->assign('chatbot_defaults', ai_chatbot_defaults());
    $ui->assign('chatbot_footer_options', $footer_options);
    $ui->assign('chatbot_footer_selected', $footer_selected);
    $ui->display('[plugin]ai_chatbot_settings.tpl');
}
function ai_chatbot_json_response(array $payload, $status = 200, array $extra_headers = [])
{
    if (!headers_sent()) {
        header('Content-Type: application/json; charset=utf-8');
        foreach ($extra_headers as $name => $value) {
            if ($name === '') {
                continue;
            }
            header($name . ': ' . $value);
        }
    }

    http_response_code($status);

    $encoded = json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    if ($encoded === false) {
        $fallback = json_encode([
            'success' => false,
            'error' => 'JSON encoding error',
        ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        echo $fallback === false ? '{"success":false,"error":"JSON encoding error"}' : $fallback;
        exit;
    }

    echo $encoded;
    exit;
}

function ai_chatbot_send_error($message, $status = 400, array $extra = [], array $headers = [])
{
    ai_chatbot_ensure_session();

    global $config;

    $error_message = is_string($message) && $message !== '' ? $message : 'Terjadi kesalahan.';
    $payload = array_merge(['success' => false, 'error' => $error_message], $extra);

    $csrf_enabled = class_exists('Csrf') && ($config['csrf_enabled'] ?? 'yes') === 'yes';
    if ($csrf_enabled && !array_key_exists('csrf_token', $payload)) {
        $payload['csrf_token'] = Csrf::generateAndStoreToken();
    }

    ai_chatbot_json_response($payload, $status, $headers);
}

function ai_chatbot_bootstrap()
{
    global $config, $app_url;

    $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
    if ($method !== 'POST' && $method !== 'GET') {
        ai_chatbot_send_error('Method not allowed', 405, [], ['Allow' => 'GET, POST']);
    }

    ai_chatbot_ensure_session();

    $settings = ai_chatbot_load_config();
    if (($settings['chatbot_enabled'] ?? '0') !== '1') {
        ai_chatbot_send_error('Chatbot is disabled', 403);
    }

    $endpoint = isset($settings['chatbot_endpoint']) ? trim((string) $settings['chatbot_endpoint']) : '';
    if ($endpoint === '' || !filter_var($endpoint, FILTER_VALIDATE_URL)) {
        ai_chatbot_send_error('Chatbot endpoint is not configured correctly', 500);
    }

    $proxy_config = ai_chatbot_collect_proxy_config($settings);
    [$proxy_id, $config_key] = ai_chatbot_store_proxy_context($proxy_config);

    $csrf_token = '';
    $csrf_enabled = class_exists('Csrf') && ($config['csrf_enabled'] ?? 'yes') === 'yes';
    if ($csrf_enabled) {
        $csrf_token = Csrf::generateAndStoreToken();
    }

    $proxy_url = rtrim($app_url, '/') . '?_route=plugin/ai_chatbot_settings/proxy';

    $payload = [
        'success' => true,
        'proxy_id' => $proxy_id,
        'config_key' => $config_key,
        'proxy_url' => $proxy_url,
    ];

    if ($csrf_token !== '') {
        $payload['csrf_token'] = $csrf_token;
    }

    ai_chatbot_json_response($payload);
}

function ai_chatbot_run_proxy()
{
    global $config;

    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        ai_chatbot_send_error('Method not allowed', 405, [], ['Allow' => 'POST']);
    }

    ai_chatbot_ensure_session();

    $raw_body = file_get_contents('php://input');
    if ($raw_body === false) {
        ai_chatbot_send_error('Could not read request body.', 400);
    }

    $request = json_decode($raw_body, true);
    if (!is_array($request)) {
        ai_chatbot_send_error('Invalid JSON payload.', 400);
    }

    $proxy_id = isset($request['proxy_id']) ? trim((string) $request['proxy_id']) : '';
    $config_key = isset($request['config_key']) ? trim((string) $request['config_key']) : '';

    $payload = $request['payload'] ?? null;
    if (!is_array($payload)) {
        ai_chatbot_send_error('Invalid message payload.', 422, [
            'proxy_id' => $proxy_id,
        ]);
    }

    $chat_input = isset($payload['chatInput']) ? trim((string) $payload['chatInput']) : '';
    if ($chat_input === '') {
        ai_chatbot_send_error('Pesan tidak boleh kosong.', 422, [
            'proxy_id' => $proxy_id,
        ]);
    }

    $csrf_enabled = class_exists('Csrf') && ($config['csrf_enabled'] ?? 'yes') === 'yes';
    $next_csrf_token = '';

    if ($csrf_enabled) {
        $csrf_token = isset($request['csrf_token']) ? (string) $request['csrf_token'] : '';
        if ($csrf_token === '' || !Csrf::check($csrf_token)) {
            $new_token = Csrf::generateAndStoreToken();
            ai_chatbot_send_error('Token keamanan tidak valid atau telah kedaluwarsa.', 419, [
                'proxy_id' => $proxy_id,
                'csrf_token' => $new_token,
            ]);
        }

        $next_csrf_token = Csrf::generateAndStoreToken();
    }

    $entry = $proxy_id !== '' ? ai_chatbot_lookup_proxy_entry($proxy_id) : null;
    $context_refreshed = false;

    if (!$entry) {
        if ($config_key === '') {
            ai_chatbot_send_error('Sesi chatbot telah kedaluwarsa. Muat ulang obrolan.', 440);
        }

        $cached_config = ai_chatbot_load_config_cache($config_key);
        if (!$cached_config) {
            ai_chatbot_send_error('Sesi chatbot telah kedaluwarsa. Muat ulang obrolan.', 440);
        }

        [$proxy_id, $config_key] = ai_chatbot_store_proxy_context($cached_config, $proxy_id ?: null, $config_key);
        $entry = ai_chatbot_lookup_proxy_entry($proxy_id);
        $context_refreshed = true;
    }

    if (!$entry || !isset($entry['config']) || !is_array($entry['config'])) {
        ai_chatbot_send_error('Konfigurasi chatbot tidak tersedia.', 500);
    }

    $proxy_config = $entry['config'];
    $endpoint = isset($proxy_config['endpoint']) ? (string) $proxy_config['endpoint'] : '';
    if ($endpoint === '' || !filter_var($endpoint, FILTER_VALIDATE_URL)) {
        ai_chatbot_send_error('Chatbot endpoint is not configured correctly', 500);
    }

    $max_chars = isset($proxy_config['user_input_max_chars']) ? (int) $proxy_config['user_input_max_chars'] : 0;
    $input_length = function_exists('mb_strlen') ? mb_strlen($chat_input, 'UTF-8') : strlen($chat_input);
    if ($max_chars > 0 && $input_length > $max_chars) {
        $extra = ['proxy_id' => $proxy_id];
        if ($next_csrf_token !== '') {
            $extra['csrf_token'] = $next_csrf_token;
        }
        ai_chatbot_send_error('Pesan melebihi batas ' . $max_chars . ' karakter.', 422, $extra);
    }

    $payload['chatInput'] = ai_chatbot_limit_length($chat_input, $max_chars > 0 ? $max_chars : 4000);

    $history_limit = 200;
    $normalized_history = [];
    if (isset($payload['history']) && is_array($payload['history'])) {
        foreach ($payload['history'] as $item) {
            if (!is_array($item)) {
                continue;
            }

            $sender = strtolower(trim((string) ($item['sender'] ?? 'user')));
            if (!in_array($sender, ['user', 'bot'], true)) {
                $sender = 'user';
            }

            $text = ai_chatbot_limit_length($item['text'] ?? '', 2000);
            if ($text === '') {
                continue;
            }

            $normalized_history[] = [
                'sender' => $sender,
                'text' => $text,
            ];

            if (count($normalized_history) >= $history_limit) {
                break;
            }
        }
    }
    $payload['history'] = $normalized_history;

    $clean_meta = [];
    if (isset($request['meta']) && is_array($request['meta'])) {
        foreach ($request['meta'] as $key => $value) {
            if (!is_string($key)) {
                continue;
            }
            if (is_scalar($value)) {
                $clean_meta[$key] = ai_chatbot_limit_length((string) $value, 500);
            }
        }
    }

    $forward_body = [
        'input' => $payload['chatInput'],
        'history' => $payload['history'],
        'meta' => $clean_meta,
        'payload' => $payload,
        'timestamp' => time(),
        'proxy_id' => $proxy_id,
    ];

    $headers = ['Content-Type: application/json', 'Accept: application/json'];

    if (!empty($clean_meta)) {
        $encoded_meta = json_encode($clean_meta, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        if ($encoded_meta !== false) {
            $headers[] = 'X-Chat-Meta: ' . rawurlencode($encoded_meta);
        }

        if (!empty($clean_meta['visitorId'])) {
            $headers[] = 'X-Chat-Visitor: ' . str_replace(["\r", "\n"], ' ', (string) $clean_meta['visitorId']);
        }

        if (!empty($clean_meta['sessionId'])) {
            $headers[] = 'X-Chat-Session: ' . str_replace(["\r", "\n"], ' ', (string) $clean_meta['sessionId']);
        }
    }

    $auth = $proxy_config['auth'] ?? ['type' => 'none'];
    switch ($auth['type']) {
        case 'basic':
            $user = (string) ($auth['basic_user'] ?? '');
            $pass = (string) ($auth['basic_pass'] ?? '');
            $headers[] = 'Authorization: Basic ' . base64_encode($user . ':' . $pass);
            break;

        case 'header':
            $key = trim((string) ($auth['header_key'] ?? ''));
            $value = (string) ($auth['header_value'] ?? '');
            if ($key !== '') {
                if (!empty($auth['as_bearer'])) {
                    $headers[] = 'Authorization: Bearer ' . $value;
                } else {
                    $headers[] = $key . ': ' . $value;
                }
            }
            break;

        case 'jwt':
            $token = '';
            if (!empty($auth['jwt_token'])) {
                $token = (string) $auth['jwt_token'];
            } elseif (!empty($auth['jwt_secret'])) {
                $now = time();
                $ttl = isset($auth['jwt_ttl']) ? (int) $auth['jwt_ttl'] : 300;
                if ($ttl <= 0) {
                    $ttl = 300;
                }
                $claims = [
                    'iat' => $now,
                    'nbf' => $now,
                    'exp' => $now + $ttl,
                ];
                if (!empty($auth['jwt_iss'])) {
                    $claims['iss'] = (string) $auth['jwt_iss'];
                }
                if (!empty($auth['jwt_aud'])) {
                    $claims['aud'] = (string) $auth['jwt_aud'];
                }
                if (!empty($auth['jwt_sub'])) {
                    $claims['sub'] = (string) $auth['jwt_sub'];
                }
                $token = ai_chatbot_make_jwt($claims, (string) $auth['jwt_secret']);
            }

            if ($token !== '') {
                $headers[] = 'Authorization: Bearer ' . $token;
            }
            break;
    }

    $request_body = json_encode($forward_body, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    if ($request_body === false) {
        $extra = ['proxy_id' => $proxy_id];
        if ($next_csrf_token !== '') {
            $extra['csrf_token'] = $next_csrf_token;
        }
        ai_chatbot_send_error('Gagal menyiapkan permintaan ke layanan AI.', 500, $extra);
    }

    $timeout = isset($proxy_config['request_timeout']) ? (int) $proxy_config['request_timeout'] : 30;
    $timeout = $timeout > 0 ? $timeout : 30;

    $result = ai_chatbot_post_with_retry($endpoint, $headers, $request_body, $timeout);

    if (!$result['success']) {
        $error_message = 'Gagal terhubung ke layanan AI.';
        if (isset($result['error']['message']) && $result['error']['message'] !== '') {
            $error_message = ai_chatbot_with_retry_notice($result['error']['message'], $error_message);
        }

        $extra = ['proxy_id' => $proxy_id];
        if ($next_csrf_token !== '') {
            $extra['csrf_token'] = $next_csrf_token;
        }
        ai_chatbot_send_error($error_message, 502, $extra);
    }

    $http_code = $result['http_code'] ?? 200;
    $body = $result['body'] ?? '';

    $decoded = json_decode($body, true);
    if ($http_code >= 400) {
        $error_message = 'Layanan AI mengembalikan kode kesalahan ' . $http_code . '.';
        if (is_array($decoded) && isset($decoded['error']) && $decoded['error'] !== '') {
            $error_message = (string) $decoded['error'];
        } elseif (is_string($body) && trim($body) !== '') {
            $error_message = trim($body);
        }

        $extra = ['proxy_id' => $proxy_id];
        if ($next_csrf_token !== '') {
            $extra['csrf_token'] = $next_csrf_token;
        }
        ai_chatbot_send_error($error_message, $http_code, $extra);
    }

    if (!is_array($decoded)) {
        $decoded = ['response' => is_string($body) ? trim($body) : ''];
    }

    if (!array_key_exists('success', $decoded)) {
        $decoded['success'] = true;
    }

    if ($next_csrf_token !== '') {
        $decoded['csrf_token'] = $next_csrf_token;
    }

    if ($context_refreshed) {
        $decoded['proxy_id'] = $proxy_id;
    }

    ai_chatbot_json_response($decoded);
}


