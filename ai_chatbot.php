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
    if ($sub_route === 'conversation-history') {
        $sub_route = 'chat-experience';
    }
    if ($sub_route === 'bootstrap') {
        ai_chatbot_bootstrap();
        return;
    }

    if ($sub_route === 'status') {
        ai_chatbot_status();
        return;
    }

    if ($sub_route === 'proxy') {
        ai_chatbot_run_proxy();
        return;
    }

    if ($sub_route === 'stream') {
        ai_chatbot_stream();
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
        'chatbot_admin_endpoint_enabled' => '0',
        'chatbot_endpoint_admin' => '',
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
        'chatbot_admin_auth_type' => 'none',
        'chatbot_admin_basic_user' => '',
        'chatbot_admin_basic_pass' => '',
        'chatbot_admin_header_key' => 'X-API-Key',
        'chatbot_admin_header_value' => '',
        'chatbot_admin_as_bearer' => 'no',
        'chatbot_admin_jwt_token' => '',
        'chatbot_admin_jwt_secret' => '',
        'chatbot_admin_jwt_iss' => '',
        'chatbot_admin_jwt_aud' => '',
        'chatbot_admin_jwt_sub' => '',
        'chatbot_admin_jwt_ttl' => '300',
        'chatbot_history_mode' => 'ttl',
        'chatbot_history_ttl' => '360',
        'chatbot_history_max_messages' => '50',
        'chatbot_request_timeout' => '30',
        'chatbot_status_throttle' => '30',
        'chatbot_response_key' => 'output',
        'chatbot_system_prompt' => '',
        'chatbot_temperature' => '0.7',
        'chatbot_max_tokens' => '512',
        'chatbot_meta_scope' => '',
        'chatbot_meta_entity_id' => '',
        'chatbot_meta_owner_id' => '',
        'chatbot_admin_response_key' => '',
        'chatbot_admin_system_prompt' => '',
        'chatbot_admin_temperature' => '0.7',
        'chatbot_admin_max_tokens' => '512',
        'chatbot_admin_meta_scope' => '',
        'chatbot_admin_meta_entity_id' => '',
        'chatbot_admin_meta_owner_id' => '',
        'chatbot_message_format' => 'markdown',
        'chatbot_typing_mode' => 'off',
        'chatbot_typing_wpm' => '600',
        'chatbot_user_input_max_chars' => '1000',
        'chatbot_handoff_enabled' => '0',
        'chatbot_handoff_label' => 'Chat dengan Admin',
        'chatbot_handoff_timeout' => '600',
        'chatbot_handoff_reason' => 'chat_dengan_admin',
        'chatbot_handoff_notice' => 'Permintaan terkirim. Admin akan segera bergabung.',
        'chatbot_frame_mode' => 'fixed',
        'chatbot_frame_width' => '340',
        'chatbot_frame_height' => '460',
        'chatbot_welcome_enabled' => '0',
        'chatbot_welcome_message' => '',
        'chatbot_theme_preset' => 'custom',
        'chatbot_header_bg' => '',
        'chatbot_header_text' => '',
        'chatbot_launcher_bg' => '',
        'chatbot_launcher_text' => '',
        'chatbot_send_bg' => '',
        'chatbot_send_text' => '',
        'chatbot_frame_bg' => '',
        'chatbot_messages_bg' => '',
        'chatbot_input_bg' => '',
        'chatbot_input_text' => '',
        'chatbot_input_border' => '',
        'chatbot_input_area_bg' => '',
        'chatbot_input_area_padding_x' => '14',
        'chatbot_input_area_padding_y' => '12',
        'chatbot_input_area_blur' => '8',
        'chatbot_bubble_radius' => '14',
        'chatbot_bubble_padding_x' => '14',
        'chatbot_bubble_padding_y' => '10',
        'chatbot_bubble_font_size' => '14',
        'chatbot_bubble_line_height' => '1.45',
        'chatbot_bubble_max_width' => '80',
        'chatbot_bubble_bot_bg' => '',
        'chatbot_bubble_bot_text' => '',
        'chatbot_bubble_bot_border' => '',
        'chatbot_bubble_user_bg' => '',
        'chatbot_bubble_user_text' => '',
        'chatbot_bubble_user_border' => '',
        'chatbot_message_font_family' => '',
        'chatbot_footer_targets' => 'ui/ui/customer/footer.tpl,ui/ui/customer/footer-public.tpl',
        'chatbot_footer_targets_admin' => 'ui/ui/admin/footer.tpl',
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
        'styling' => 'styling-settings',
    ];
}


function ai_chatbot_section_field_map()
{
    return [
        'general' => [
            'chatbot_enabled',
            'chatbot_endpoint',
            'chatbot_admin_endpoint_enabled',
            'chatbot_endpoint_admin',
            'chatbot_admin_auth_type',
            'chatbot_admin_header_key',
            'chatbot_admin_header_value',
            'chatbot_admin_as_bearer',
            'chatbot_admin_basic_user',
            'chatbot_admin_basic_pass',
            'chatbot_admin_jwt_token',
            'chatbot_admin_jwt_secret',
            'chatbot_admin_jwt_iss',
            'chatbot_admin_jwt_aud',
            'chatbot_admin_jwt_sub',
            'chatbot_admin_jwt_ttl',
            'chatbot_footer_targets',
            'chatbot_footer_targets_admin',
            'chatbot_request_timeout',
            'chatbot_status_throttle',
            'chatbot_handoff_enabled',
            'chatbot_handoff_label',
            'chatbot_handoff_timeout',
            'chatbot_handoff_reason',
            'chatbot_handoff_notice',
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
            'chatbot_message_format',
            'chatbot_typing_mode',
            'chatbot_typing_wpm',
            'chatbot_user_input_max_chars',
            'chatbot_handoff_enabled',
            'chatbot_handoff_label',
            'chatbot_handoff_timeout',
            'chatbot_handoff_reason',
            'chatbot_handoff_notice',
            'chatbot_frame_mode',
            'chatbot_frame_width',
            'chatbot_frame_height',
            'chatbot_history_mode',
            'chatbot_history_ttl',
            'chatbot_history_max_messages',
        ],
        'styling' => [
            'chatbot_theme_preset',
            'chatbot_header_bg',
            'chatbot_header_text',
            'chatbot_launcher_bg',
            'chatbot_launcher_text',
            'chatbot_send_bg',
            'chatbot_send_text',
            'chatbot_frame_bg',
            'chatbot_messages_bg',
            'chatbot_input_bg',
            'chatbot_input_text',
            'chatbot_input_border',
            'chatbot_input_area_bg',
            'chatbot_input_area_padding_x',
            'chatbot_input_area_padding_y',
            'chatbot_input_area_blur',
            'chatbot_bubble_radius',
            'chatbot_bubble_padding_x',
            'chatbot_bubble_padding_y',
            'chatbot_bubble_font_size',
            'chatbot_bubble_line_height',
            'chatbot_bubble_max_width',
            'chatbot_bubble_bot_bg',
            'chatbot_bubble_bot_text',
            'chatbot_bubble_bot_border',
            'chatbot_bubble_user_bg',
            'chatbot_bubble_user_text',
            'chatbot_bubble_user_border',
            'chatbot_message_font_family',
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

function ai_chatbot_group_footer_options(array $options)
{
    $grouped = [
        'public' => [],
        'admin' => [],
    ];

    foreach ($options as $option) {
        $path = isset($option['path']) ? (string) $option['path'] : '';
        if (strpos($path, '/admin/') !== false) {
            $grouped['admin'][] = $option;
        } else {
            $grouped['public'][] = $option;
        }
    }

    return $grouped;
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
if (!defined('AI_CHATBOT_SSE_TTL')) {
    define('AI_CHATBOT_SSE_TTL', 900);
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

function ai_chatbot_setting_present($key)
{
    if (!is_string($key) || $key === '') {
        return false;
    }
    if (!isset($GLOBALS['config']) || !is_array($GLOBALS['config'])) {
        return false;
    }
    if (!array_key_exists($key, $GLOBALS['config'])) {
        return false;
    }

    $value = $GLOBALS['config'][$key];
    if (is_string($value)) {
        return trim($value) !== '';
    }

    return $value !== null;
}

function ai_chatbot_store_sse_context($session_id, array $transport)
{
    ai_chatbot_ensure_session();
    $session_id = trim((string) $session_id);
    $token = trim((string) ($transport['token'] ?? ''));
    $endpoint = trim((string) ($transport['endpoint'] ?? ''));

    if ($session_id === '' || $token === '' || $endpoint === '') {
        return;
    }

    if (!isset($_SESSION['ai_chatbot_sse']) || !is_array($_SESSION['ai_chatbot_sse'])) {
        $_SESSION['ai_chatbot_sse'] = [];
    }

    $_SESSION['ai_chatbot_sse'][$session_id] = [
        'token' => $token,
        'endpoint' => $endpoint,
        'channel' => isset($transport['channel']) ? (string) $transport['channel'] : '',
        'expires_at' => time() + AI_CHATBOT_SSE_TTL,
    ];
}

function ai_chatbot_get_sse_context($session_id, $token)
{
    ai_chatbot_ensure_session();
    $session_id = trim((string) $session_id);
    $token = trim((string) $token);

    if ($session_id === '' || $token === '') {
        return null;
    }

    if (
        !isset($_SESSION['ai_chatbot_sse']) ||
        !is_array($_SESSION['ai_chatbot_sse']) ||
        !isset($_SESSION['ai_chatbot_sse'][$session_id])
    ) {
        return null;
    }

    $context = $_SESSION['ai_chatbot_sse'][$session_id];
    $expires_at = isset($context['expires_at']) ? (int) $context['expires_at'] : 0;
    if ($expires_at > 0 && $expires_at < time()) {
        unset($_SESSION['ai_chatbot_sse'][$session_id]);
        return null;
    }

    $stored_token = (string) ($context['token'] ?? '');
    if ($stored_token === '' || !hash_equals($stored_token, $token)) {
        return null;
    }

    return $context;
}

function ai_chatbot_clear_sse_context($session_id)
{
    ai_chatbot_ensure_session();
    $session_id = trim((string) $session_id);
    if ($session_id === '') {
        return;
    }
    if (isset($_SESSION['ai_chatbot_sse'][$session_id])) {
        unset($_SESSION['ai_chatbot_sse'][$session_id]);
    }
}

function ai_chatbot_gateway_base_url($endpoint)
{
    $endpoint = trim((string) $endpoint);
    if ($endpoint === '') {
        return '';
    }
    $parts = parse_url($endpoint);
    if (!is_array($parts) || empty($parts['scheme']) || empty($parts['host'])) {
        return '';
    }
    $base = $parts['scheme'] . '://' . $parts['host'];
    if (!empty($parts['port'])) {
        $base .= ':' . (int) $parts['port'];
    }
    return $base;
}

function ai_chatbot_build_sse_url($base, $endpoint, array $params)
{
    $endpoint = trim((string) $endpoint);
    if ($endpoint === '') {
        return '';
    }

    $has_scheme = (bool) preg_match('#^https?://#i', $endpoint);
    $full = $has_scheme ? $endpoint : rtrim((string) $base, '/') . '/' . ltrim($endpoint, '/');

    $parts = parse_url($full);
    if (!is_array($parts) || empty($parts['scheme']) || empty($parts['host'])) {
        return '';
    }

    $query = [];
    if (!empty($parts['query'])) {
        parse_str($parts['query'], $query);
    }
    foreach ($params as $key => $value) {
        if ($value === null || $value === '') {
            continue;
        }
        $query[$key] = $value;
    }

    $path = $parts['path'] ?? '';
    $port = isset($parts['port']) ? ':' . (int) $parts['port'] : '';
    $query_string = $query ? ('?' . http_build_query($query)) : '';

    return $parts['scheme'] . '://' . $parts['host'] . $port . $path . $query_string;
}

function ai_chatbot_build_ws_url($base, $endpoint, array $params)
{
    $endpoint = trim((string) $endpoint);
    if ($endpoint === '') {
        return '';
    }

    $has_scheme = (bool) preg_match('#^wss?://#i', $endpoint) || preg_match('#^https?://#i', $endpoint);
    $full = $has_scheme ? $endpoint : rtrim((string) $base, '/') . '/' . ltrim($endpoint, '/');

    $parts = parse_url($full);
    if (!is_array($parts) || empty($parts['scheme']) || empty($parts['host'])) {
        return '';
    }

    $scheme = strtolower((string) $parts['scheme']);
    if ($scheme === 'http') {
        $scheme = 'ws';
    } elseif ($scheme === 'https') {
        $scheme = 'wss';
    }

    $query = [];
    if (!empty($parts['query'])) {
        parse_str($parts['query'], $query);
    }
    foreach ($params as $key => $value) {
        if ($value === null || $value === '') {
            continue;
        }
        $query[$key] = $value;
    }

    $path = $parts['path'] ?? '';
    $port = isset($parts['port']) ? ':' . (int) $parts['port'] : '';
    $query_string = $query ? ('?' . http_build_query($query)) : '';

    return $scheme . '://' . $parts['host'] . $port . $path . $query_string;
}
if (!defined('AI_CHATBOT_AUTOSYNC_REGISTERED')) {
    define('AI_CHATBOT_AUTOSYNC_REGISTERED', true);

    register_shutdown_function(static function () {
        if (!isset($GLOBALS['config']) || !is_array($GLOBALS['config'])) {
            return;
        }

        $settings = ai_chatbot_load_config();
        $public_targets = ai_chatbot_parse_footer_targets($settings['chatbot_footer_targets'] ?? '');
        $admin_targets = ai_chatbot_parse_footer_targets($settings['chatbot_footer_targets_admin'] ?? '');
        $targets = array_values(array_unique(array_merge($public_targets, $admin_targets)));
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

function ai_chatbot_detect_context($requested = '')
{
    $requested = strtolower(trim((string) $requested));
    $is_admin = Admin::getID() ? true : false;
    $is_user = User::getID() ? true : false;

    if ($requested === 'admin') {
        return $is_admin ? 'admin' : ($is_user ? 'customer' : 'public');
    }

    if ($requested === 'customer') {
        return $is_user ? 'customer' : ($is_admin ? 'admin' : 'public');
    }

    if ($requested === 'public') {
        return 'public';
    }

    if ($is_admin) {
        return 'admin';
    }

    if ($is_user) {
        return 'customer';
    }

    return 'public';
}

function ai_chatbot_resolve_endpoint(array $settings, $context = '')
{
    $context = $context !== '' ? $context : ai_chatbot_detect_context();
    $default_endpoint = isset($settings['chatbot_endpoint']) ? trim((string) $settings['chatbot_endpoint']) : '';

    $admin_enabled = ($settings['chatbot_admin_endpoint_enabled'] ?? '0') === '1';
    if ($context === 'admin' && $admin_enabled) {
        $admin_endpoint = isset($settings['chatbot_endpoint_admin']) ? trim((string) $settings['chatbot_endpoint_admin']) : '';
        if ($admin_endpoint !== '') {
            return $admin_endpoint;
        }
    }

    return $default_endpoint;
}

function ai_chatbot_is_gateway_endpoint($endpoint)
{
    $endpoint = trim((string) $endpoint);
    if ($endpoint === '') {
        return false;
    }

    $path = parse_url($endpoint, PHP_URL_PATH);
    if (!is_string($path) || $path === '') {
        return false;
    }

    return (bool) preg_match('#/ext/[^/]+/ai/?$#i', $path);
}

function ai_chatbot_collect_proxy_config(array $settings)
{
    $context = ai_chatbot_detect_context(_req('context'));
    $use_admin = $context === 'admin' && (($settings['chatbot_admin_endpoint_enabled'] ?? '0') === '1');
    $endpoint = ai_chatbot_resolve_endpoint($settings, $context);
    $auth_type = $use_admin
        ? (isset($settings['chatbot_admin_auth_type']) ? strtolower((string) $settings['chatbot_admin_auth_type']) : 'none')
        : (isset($settings['chatbot_auth_type']) ? strtolower((string) $settings['chatbot_auth_type']) : 'none');

    $auth = ['type' => in_array($auth_type, ['basic', 'header', 'jwt'], true) ? $auth_type : 'none'];

    switch ($auth['type']) {
        case 'basic':
            $auth['basic_user'] = $use_admin ? ($settings['chatbot_admin_basic_user'] ?? '') : ($settings['chatbot_basic_user'] ?? '');
            $auth['basic_pass'] = $use_admin ? ($settings['chatbot_admin_basic_pass'] ?? '') : ($settings['chatbot_basic_pass'] ?? '');
            break;

        case 'header':
            $auth['header_key'] = $use_admin ? ($settings['chatbot_admin_header_key'] ?? 'X-API-Key') : ($settings['chatbot_header_key'] ?? 'X-API-Key');
            $auth['header_value'] = $use_admin ? ($settings['chatbot_admin_header_value'] ?? '') : ($settings['chatbot_header_value'] ?? '');
            $auth['as_bearer'] = $use_admin
                ? (($settings['chatbot_admin_as_bearer'] ?? 'no') === 'yes')
                : (($settings['chatbot_as_bearer'] ?? 'no') === 'yes');
            break;

        case 'jwt':
            $auth['jwt_token'] = $use_admin ? ($settings['chatbot_admin_jwt_token'] ?? '') : ($settings['chatbot_jwt_token'] ?? '');
            $auth['jwt_secret'] = $use_admin ? ($settings['chatbot_admin_jwt_secret'] ?? '') : ($settings['chatbot_jwt_secret'] ?? '');
            $auth['jwt_iss'] = $use_admin ? ($settings['chatbot_admin_jwt_iss'] ?? '') : ($settings['chatbot_jwt_iss'] ?? '');
            $auth['jwt_aud'] = $use_admin ? ($settings['chatbot_admin_jwt_aud'] ?? '') : ($settings['chatbot_jwt_aud'] ?? '');
            $auth['jwt_sub'] = $use_admin ? ($settings['chatbot_admin_jwt_sub'] ?? '') : ($settings['chatbot_jwt_sub'] ?? '');
            $auth['jwt_ttl'] = $use_admin
                ? (isset($settings['chatbot_admin_jwt_ttl']) ? (int) $settings['chatbot_admin_jwt_ttl'] : 300)
                : (isset($settings['chatbot_jwt_ttl']) ? (int) $settings['chatbot_jwt_ttl'] : 300);
            if ($auth['jwt_ttl'] <= 0) {
                $auth['jwt_ttl'] = 300;
            }
            break;
    }

    return [
        'endpoint' => $endpoint,
        'context' => $context,
        'use_admin' => $use_admin,
        'auth' => $auth,
        'request_timeout' => (int) ai_chatbot_normalise_timeout($settings['chatbot_request_timeout'] ?? 30, 30),
        'user_input_max_chars' => isset($settings['chatbot_user_input_max_chars'])
            ? (int) $settings['chatbot_user_input_max_chars']
            : 1000,
        'response_key' => isset($settings[$use_admin ? 'chatbot_admin_response_key' : 'chatbot_response_key'])
            ? trim((string) $settings[$use_admin ? 'chatbot_admin_response_key' : 'chatbot_response_key'])
            : '',
        'system_prompt' => isset($settings[$use_admin ? 'chatbot_admin_system_prompt' : 'chatbot_system_prompt'])
            ? (string) $settings[$use_admin ? 'chatbot_admin_system_prompt' : 'chatbot_system_prompt']
            : '',
        'temperature' => isset($settings[$use_admin ? 'chatbot_admin_temperature' : 'chatbot_temperature'])
            ? (float) $settings[$use_admin ? 'chatbot_admin_temperature' : 'chatbot_temperature']
            : 0.7,
        'max_tokens' => isset($settings[$use_admin ? 'chatbot_admin_max_tokens' : 'chatbot_max_tokens'])
            ? (int) $settings[$use_admin ? 'chatbot_admin_max_tokens' : 'chatbot_max_tokens']
            : 512,
        'explicit_overrides' => [
            'system_prompt' => ai_chatbot_setting_present($use_admin ? 'chatbot_admin_system_prompt' : 'chatbot_system_prompt'),
            'temperature' => ai_chatbot_setting_present($use_admin ? 'chatbot_admin_temperature' : 'chatbot_temperature'),
            'max_tokens' => ai_chatbot_setting_present($use_admin ? 'chatbot_admin_max_tokens' : 'chatbot_max_tokens'),
        ],
        'meta_overrides' => [
            'scope' => isset($settings[$use_admin ? 'chatbot_admin_meta_scope' : 'chatbot_meta_scope'])
                ? trim((string) $settings[$use_admin ? 'chatbot_admin_meta_scope' : 'chatbot_meta_scope'])
                : '',
            'entity_id' => isset($settings[$use_admin ? 'chatbot_admin_meta_entity_id' : 'chatbot_meta_entity_id'])
                ? trim((string) $settings[$use_admin ? 'chatbot_admin_meta_entity_id' : 'chatbot_meta_entity_id'])
                : '',
            'owner_id' => isset($settings[$use_admin ? 'chatbot_admin_meta_owner_id' : 'chatbot_meta_owner_id'])
                ? trim((string) $settings[$use_admin ? 'chatbot_admin_meta_owner_id' : 'chatbot_meta_owner_id'])
                : '',
        ],
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
        case 'chatbot_admin_endpoint_enabled':
        case 'chatbot_welcome_enabled':
        case 'chatbot_handoff_enabled':
            return (in_array(strtolower((string) $value), ['1', 'yes', 'true'], true)) ? '1' : '0';

        case 'chatbot_footer_targets':
        case 'chatbot_footer_targets_admin':
            return ai_chatbot_normalize_footer_targets($value);

        case 'chatbot_endpoint':
        case 'chatbot_endpoint_admin':
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
        case 'chatbot_admin_auth_type':
            $value = strtolower((string) $value);
            return in_array($value, ['none', 'basic', 'header', 'jwt'], true) ? $value : 'none';

        case 'chatbot_basic_user':
        case 'chatbot_admin_basic_user':
            return ai_chatbot_limit_length($value, 120);

        case 'chatbot_basic_pass':
        case 'chatbot_admin_basic_pass':
            return (string) $value;

        case 'chatbot_header_key':
        case 'chatbot_admin_header_key':
            $value = preg_replace('/[^A-Za-z0-9\-]/', '', (string) $value);
            return $value !== '' ? $value : 'X-API-Key';

        case 'chatbot_header_value':
        case 'chatbot_admin_header_value':
            return (string) $value;

        case 'chatbot_as_bearer':
        case 'chatbot_admin_as_bearer':
            return (strtolower((string) $value) === 'yes') ? 'yes' : 'no';

        case 'chatbot_jwt_token':
        case 'chatbot_jwt_secret':
        case 'chatbot_jwt_iss':
        case 'chatbot_jwt_aud':
        case 'chatbot_jwt_sub':
        case 'chatbot_admin_jwt_token':
        case 'chatbot_admin_jwt_secret':
        case 'chatbot_admin_jwt_iss':
        case 'chatbot_admin_jwt_aud':
        case 'chatbot_admin_jwt_sub':
            return ai_chatbot_limit_length($value, 255);

        case 'chatbot_jwt_ttl':
        case 'chatbot_admin_jwt_ttl':
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

        case 'chatbot_status_throttle':
            $n = (int) $value;
            if ($n < 0) {
                $n = 0;
            } elseif ($n > 600) {
                $n = 600;
            }
            return (string) $n;

        case 'chatbot_response_key':
        case 'chatbot_admin_response_key':
            $value = trim((string) $value);
            if ($value === '') {
                return '';
            }
            $value = preg_replace('/[^A-Za-z0-9_.-]/', '', $value);
            return ai_chatbot_limit_length($value, 80);

        case 'chatbot_system_prompt':
        case 'chatbot_admin_system_prompt':
            return ai_chatbot_limit_length($value, 2000);

        case 'chatbot_temperature':
        case 'chatbot_admin_temperature':
            $n = is_numeric($value) ? (float) $value : 0.7;
            if ($n < 0) {
                $n = 0;
            } elseif ($n > 2) {
                $n = 2;
            }
            return rtrim(rtrim(sprintf('%.2F', $n), '0'), '.');

        case 'chatbot_max_tokens':
        case 'chatbot_admin_max_tokens':
            $n = (int) $value;
            if ($n < 16) {
                $n = 16;
            } elseif ($n > 4096) {
                $n = 4096;
            }
            return (string) $n;

        case 'chatbot_meta_scope':
        case 'chatbot_admin_meta_scope':
            $value = strtolower(trim((string) $value));
            if ($value === '') {
                return '';
            }
            $value = preg_replace('/[^a-z0-9_.-]/', '', $value);
            return ai_chatbot_limit_length($value, 40);

        case 'chatbot_meta_entity_id':
        case 'chatbot_meta_owner_id':
        case 'chatbot_admin_meta_entity_id':
        case 'chatbot_admin_meta_owner_id':
            return ai_chatbot_limit_length($value, 120);

        case 'chatbot_message_format':
            $value = strtolower((string) $value);
            return in_array($value, ['plain', 'markdown', 'markdown_v2'], true) ? $value : 'markdown';

        case 'chatbot_user_input_max_chars':
            $n = (int) $value;
            if ($n < 100) {
                $n = 100;
            } elseif ($n > 4000) {
                $n = 4000;
            }
            return (string) $n;

        case 'chatbot_handoff_label':
            return ai_chatbot_limit_length($value, 80);

        case 'chatbot_handoff_timeout':
            $n = (int) $value;
            if ($n < 0) {
                $n = 0;
            } elseif ($n > 86400) {
                $n = 86400;
            }
            return (string) $n;

        case 'chatbot_handoff_reason':
            return ai_chatbot_limit_length($value, 120);

        case 'chatbot_handoff_notice':
            return ai_chatbot_limit_length($value, 200);

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

        case 'chatbot_theme_preset':
            $value = strtolower((string) $value);
            return in_array($value, ['custom', 'ocean', 'dark_glass', 'minimal', 'neon', 'forest', 'modern', 'aesthetic', 'futuristic'], true)
                ? $value
                : 'custom';

        case 'chatbot_header_bg':
        case 'chatbot_header_text':
        case 'chatbot_launcher_bg':
        case 'chatbot_launcher_text':
        case 'chatbot_send_bg':
        case 'chatbot_send_text':
        case 'chatbot_frame_bg':
        case 'chatbot_messages_bg':
        case 'chatbot_input_bg':
        case 'chatbot_input_text':
        case 'chatbot_input_border':
        case 'chatbot_input_area_bg':
            return ai_chatbot_limit_length($value, 120);

        case 'chatbot_input_area_padding_x':
        case 'chatbot_input_area_padding_y':
            $padding = (int) $value;
            return (string) max(6, min($padding, 24));

        case 'chatbot_input_area_blur':
            $blur = (int) $value;
            return (string) max(0, min($blur, 20));

        case 'chatbot_bubble_radius':
            $radius = (int) $value;
            return (string) max(0, min($radius, 40));

        case 'chatbot_bubble_padding_x':
        case 'chatbot_bubble_padding_y':
            $padding = (int) $value;
            return (string) max(0, min($padding, 30));

        case 'chatbot_bubble_font_size':
            $font = (int) $value;
            return (string) max(10, min($font, 20));

        case 'chatbot_bubble_line_height':
            $line = is_numeric($value) ? (float) $value : 1.45;
            if ($line <= 0) {
                $line = 1.45;
            }
            return rtrim(rtrim(sprintf('%.2F', max(1.1, min($line, 2.0))), '0'), '.');

        case 'chatbot_bubble_max_width':
            $width = (int) $value;
            return (string) max(60, min($width, 100));

        case 'chatbot_bubble_bot_bg':
        case 'chatbot_bubble_bot_text':
        case 'chatbot_bubble_bot_border':
        case 'chatbot_bubble_user_bg':
        case 'chatbot_bubble_user_text':
        case 'chatbot_bubble_user_border':
            return ai_chatbot_limit_length($value, 120);

        case 'chatbot_message_font_family':
            return ai_chatbot_limit_length($value, 160);

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
            if (isset($post_data['chatbot_footer_targets_admin']) && is_array($post_data['chatbot_footer_targets_admin'])) {
                $post_data['chatbot_footer_targets_admin'] = implode(',', $post_data['chatbot_footer_targets_admin']);
            } else {
                $post_data['chatbot_footer_targets_admin'] = '';
            }
        } elseif (isset($post_data['chatbot_footer_targets']) && is_array($post_data['chatbot_footer_targets'])) {
            $post_data['chatbot_footer_targets'] = implode(',', $post_data['chatbot_footer_targets']);
        } elseif (isset($post_data['chatbot_footer_targets_admin']) && is_array($post_data['chatbot_footer_targets_admin'])) {
            $post_data['chatbot_footer_targets_admin'] = implode(',', $post_data['chatbot_footer_targets_admin']);
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
            $public_targets = ai_chatbot_parse_footer_targets($current_config['chatbot_footer_targets'] ?? '');
            $admin_targets = ai_chatbot_parse_footer_targets($current_config['chatbot_footer_targets_admin'] ?? '');
            $selected_targets = array_values(array_unique(array_merge($public_targets, $admin_targets)));
            ai_chatbot_sync_footer_includes(($current_config['chatbot_enabled'] ?? '0') === '1', $selected_targets);
            _msglog('s', 'Settings saved successfully');
        } else {
            _msglog('e', 'No settings were updated.');
        }

        r2(getUrl('plugin/ai_chatbot_settings/' . $active_section));
    }

    $footer_options = ai_chatbot_footer_options();
    $footer_public_selected = ai_chatbot_parse_footer_targets($current_config['chatbot_footer_targets'] ?? '');
    $footer_admin_selected = ai_chatbot_parse_footer_targets($current_config['chatbot_footer_targets_admin'] ?? '');

    $selected_targets = array_values(array_unique(array_merge($footer_public_selected, $footer_admin_selected)));
    ai_chatbot_sync_footer_includes(($current_config['chatbot_enabled'] ?? '0') === '1', $selected_targets);

    foreach ($footer_options as $option_key => &$option) {
        $option_path = $option['path'] ?? $option_key;
        $option_path = ai_chatbot_normalize_target_path($option_path);
        $option['path'] = $option_path;
    }
    unset($option);

    $footer_grouped = ai_chatbot_group_footer_options(array_values($footer_options));
    foreach ($footer_grouped['public'] as &$option) {
        $option['selected'] = in_array($option['path'], $footer_public_selected, true);
    }
    unset($option);
    foreach ($footer_grouped['admin'] as &$option) {
        $option['selected'] = in_array($option['path'], $footer_admin_selected, true);
    }
    unset($option);

    $ui->assign('config', $current_config);
    if (class_exists('Csrf') && ($config['csrf_enabled'] ?? 'yes') === 'yes') {
        $ui->assign('csrf_token', Csrf::generateAndStoreToken());
    }
    $ui->assign('chatbot_defaults', ai_chatbot_defaults());
    $ui->assign('chatbot_footer_public_options', $footer_grouped['public']);
    $ui->assign('chatbot_footer_admin_options', $footer_grouped['admin']);
    $ui->assign('chatbot_footer_public_selected', $footer_public_selected);
    $ui->assign('chatbot_footer_admin_selected', $footer_admin_selected);
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

function ai_chatbot_append_auth_headers(array &$headers, array $auth)
{
    switch ($auth['type'] ?? 'none') {
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
}

function ai_chatbot_status()
{
    $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
    if ($method !== 'GET' && $method !== 'POST') {
        ai_chatbot_send_error('Method not allowed', 405, [], ['Allow' => 'GET, POST']);
    }

    ai_chatbot_ensure_session();

    $settings = ai_chatbot_load_config();
    if (($settings['chatbot_enabled'] ?? '0') !== '1') {
        ai_chatbot_json_response([
            'success' => true,
            'status' => 'offline',
            'reason' => 'disabled',
        ]);
    }

    $proxy_config = ai_chatbot_collect_proxy_config($settings);
    $endpoint = isset($proxy_config['endpoint']) ? trim((string) $proxy_config['endpoint']) : '';
    if ($endpoint === '' || !filter_var($endpoint, FILTER_VALIDATE_URL)) {
        ai_chatbot_json_response([
            'success' => true,
            'status' => 'offline',
            'reason' => 'invalid_endpoint',
        ]);
    }

    $headers = ['Content-Type: application/json', 'Accept: application/json'];
    ai_chatbot_append_auth_headers($headers, $proxy_config['auth'] ?? ['type' => 'none']);

    $request_body = json_encode(['ping' => true], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    if ($request_body === false) {
        $request_body = '{"ping":true}';
    }

    $timeout = isset($proxy_config['request_timeout']) ? (int) $proxy_config['request_timeout'] : 30;
    $timeout = max(2, min(5, $timeout));

    $result = ai_chatbot_post_with_retry($endpoint, $headers, $request_body, $timeout, 1, 0, 0);

    if (!$result['success']) {
        ai_chatbot_json_response([
            'success' => true,
            'status' => 'offline',
            'reason' => 'connection_failed',
        ]);
    }

    $http_code = isset($result['http_code']) ? (int) $result['http_code'] : 0;
    $online = $http_code >= 200 && $http_code < 500;

    ai_chatbot_json_response([
        'success' => true,
        'status' => $online ? 'online' : 'offline',
        'http_code' => $http_code,
    ]);
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

    $proxy_config = ai_chatbot_collect_proxy_config($settings);
    $endpoint = isset($proxy_config['endpoint']) ? trim((string) $proxy_config['endpoint']) : '';
    if ($endpoint === '' || !filter_var($endpoint, FILTER_VALIDATE_URL)) {
        ai_chatbot_send_error('Chatbot endpoint is not configured correctly', 500);
    }

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
        'request_timeout' => isset($proxy_config['request_timeout']) ? (int) $proxy_config['request_timeout'] : 30,
    ];

    if ($csrf_token !== '') {
        $payload['csrf_token'] = $csrf_token;
    }

    ai_chatbot_json_response($payload);
}

function ai_chatbot_stream()
{
    $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
    if ($method !== 'GET') {
        ai_chatbot_send_error('Method not allowed', 405, [], ['Allow' => 'GET']);
    }

    ai_chatbot_ensure_session();

    $session_id = isset($_GET['session_id']) ? ai_chatbot_limit_length((string) $_GET['session_id'], 120) : '';
    $token = isset($_GET['token']) ? ai_chatbot_limit_length((string) $_GET['token'], 200) : '';
    if ($session_id === '' || $token === '') {
        http_response_code(400);
        echo 'Missing session_id or token';
        exit;
    }

    $context = ai_chatbot_get_sse_context($session_id, $token);
    if (!$context) {
        http_response_code(403);
        echo 'Invalid or expired stream token';
        exit;
    }

    $settings = ai_chatbot_load_config();
    if (($settings['chatbot_enabled'] ?? '0') !== '1') {
        http_response_code(403);
        echo 'Chatbot disabled';
        exit;
    }

    $proxy_config = ai_chatbot_collect_proxy_config($settings);
    $base = ai_chatbot_gateway_base_url($proxy_config['endpoint'] ?? '');
    $transport_endpoint = $context['endpoint'] ?? '';
    $sse_url = ai_chatbot_build_sse_url($base, $transport_endpoint, [
        'session_id' => $session_id,
        'token' => $token,
    ]);

    if ($sse_url === '') {
        http_response_code(500);
        echo 'Invalid SSE endpoint';
        exit;
    }

    @ini_set('output_buffering', 'off');
    @ini_set('zlib.output_compression', '0');
    while (ob_get_level() > 0) {
        @ob_end_flush();
    }

    ignore_user_abort(true);
    @set_time_limit(0);

    if (!headers_sent()) {
        header('Content-Type: text/event-stream; charset=utf-8');
        header('Cache-Control: no-cache, no-transform');
        header('Connection: keep-alive');
        header('X-Accel-Buffering: no');
    }

    echo "retry: 3000\n\n";
    @ob_flush();
    @flush();

    $headers = ['Accept: text/event-stream'];
    ai_chatbot_append_auth_headers($headers, $proxy_config['auth'] ?? ['type' => 'none']);

    $last_activity = time();
    $heartbeat_interval = 15;

    $ch = curl_init($sse_url);
    curl_setopt_array($ch, [
        CURLOPT_HTTPHEADER => $headers,
        CURLOPT_RETURNTRANSFER => false,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_CONNECTTIMEOUT => 15,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_HEADER => false,
        CURLOPT_WRITEFUNCTION => static function ($ch, $data) use (&$last_activity) {
            $last_activity = time();
            echo $data;
            @ob_flush();
            @flush();
            if (connection_aborted()) {
                return 0;
            }
            return strlen($data);
        },
    ]);

    $mh = curl_multi_init();
    curl_multi_add_handle($mh, $ch);
    $running = null;

    do {
        $status = curl_multi_exec($mh, $running);
        if ($status === CURLM_CALL_MULTI_PERFORM) {
            continue;
        }

        if (connection_aborted()) {
            break;
        }

        $now = time();
        if ($now - $last_activity >= $heartbeat_interval) {
            echo ": ping\n\n";
            @ob_flush();
            @flush();
            $last_activity = $now;
        }

        if ($running) {
            curl_multi_select($mh, 1.0);
        }
    } while ($running);

    curl_multi_remove_handle($mh, $ch);
    curl_close($ch);
    curl_multi_close($mh);
    exit;
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

    $route = isset($payload['route']) ? strtolower(trim((string) $payload['route'])) : '';
    $handoff_flag = false;
    if (array_key_exists('handoff', $payload)) {
        $handoff_flag = filter_var($payload['handoff'], FILTER_VALIDATE_BOOLEAN);
    }
    $handoff_request = in_array($route, ['handoff', 'handoff_off', 'handoff_timeout', 'handoff_status', 'handoff-status', 'handoff_state', 'handoff-state', 'admin'], true) || $handoff_flag;

    $chat_input = isset($payload['chatInput']) ? trim((string) $payload['chatInput']) : '';
    $payload_text = isset($payload['text']) ? trim((string) $payload['text']) : '';
    if ($chat_input === '' && !$handoff_request) {
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

    $is_gateway_endpoint = ai_chatbot_is_gateway_endpoint($endpoint);

    $max_chars = isset($proxy_config['user_input_max_chars']) ? (int) $proxy_config['user_input_max_chars'] : 0;
    $input_length = function_exists('mb_strlen') ? mb_strlen($chat_input, 'UTF-8') : strlen($chat_input);
    if ($max_chars > 0 && $input_length > $max_chars) {
        $extra = ['proxy_id' => $proxy_id];
        if ($next_csrf_token !== '') {
            $extra['csrf_token'] = $next_csrf_token;
        }
        ai_chatbot_send_error('Pesan melebihi batas ' . $max_chars . ' karakter.', 422, $extra);
    }

    if ($chat_input === '' && $handoff_request && $payload_text !== '') {
        $chat_input = $payload_text;
    }
    $payload['chatInput'] = ai_chatbot_limit_length($chat_input, $max_chars > 0 ? $max_chars : 4000);
    $payload['text'] = $payload['chatInput'];

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

    $meta_overrides = $proxy_config['meta_overrides'] ?? [];
    $override_scope = isset($meta_overrides['scope']) ? trim((string) $meta_overrides['scope']) : '';
    $override_entity = isset($meta_overrides['entity_id']) ? trim((string) $meta_overrides['entity_id']) : '';
    $override_owner = isset($meta_overrides['owner_id']) ? trim((string) $meta_overrides['owner_id']) : '';

    if ($is_gateway_endpoint) {
        $override_scope = '';
        $override_entity = '';
    }

    if ($override_scope !== '') {
        $clean_meta['scope'] = $override_scope;
    }
    if ($override_entity !== '') {
        $clean_meta['entityId'] = $override_entity;
    }
    if ($override_owner !== '') {
        $clean_meta['ownerId'] = $override_owner;
    }

    if ($is_gateway_endpoint) {
        unset($clean_meta['scope'], $clean_meta['entityId'], $clean_meta['entity_id']);
    }

    if (class_exists('User') && User::getID()) {
        $customer = User::_info();
        $customer_username = isset($customer['username']) ? trim((string) $customer['username']) : '';
        $customer_phone = isset($customer['phonenumber']) ? trim((string) $customer['phonenumber']) : '';
        if ($customer_phone === '' && isset($customer['phone'])) {
            $customer_phone = trim((string) $customer['phone']);
        }
        $customer_name = isset($customer['fullname']) ? trim((string) $customer['fullname']) : '';
        if ($customer_name === '' && isset($customer['name'])) {
            $customer_name = trim((string) $customer['name']);
        }

        if ($customer_username !== '') {
            $clean_meta['username'] = ai_chatbot_limit_length($customer_username, 120);
        }
        if ($customer_phone !== '') {
            $clean_meta['phone'] = ai_chatbot_limit_length($customer_phone, 120);
        }
        if ($customer_name !== '') {
            $clean_meta['name'] = ai_chatbot_limit_length($customer_name, 160);
        }

        $preferred_session = $customer_phone !== '' ? $customer_phone : $customer_username;
        if ($preferred_session !== '') {
            $clean_meta['sessionId'] = ai_chatbot_limit_length($preferred_session, 120);
        }
    }

    $session_id = '';
    if (!empty($clean_meta['sessionId'])) {
        $session_id = trim((string) $clean_meta['sessionId']);
    }
    if ($session_id === '' && !empty($payload['session_id'])) {
        $session_id = trim((string) $payload['session_id']);
    }
    if ($session_id === '' && !empty($payload['sessionId'])) {
        $session_id = trim((string) $payload['sessionId']);
    }
    if ($session_id === '' && !empty($payload['sessionid'])) {
        $session_id = trim((string) $payload['sessionid']);
    }
    if ($session_id === '' && !empty($request['session_id'])) {
        $session_id = trim((string) $request['session_id']);
    }
    if ($session_id === '' && !empty($request['sessionId'])) {
        $session_id = trim((string) $request['sessionId']);
    }
    if ($session_id === '' && session_status() === PHP_SESSION_ACTIVE) {
        $session_id = session_id();
    }
    $session_id = ai_chatbot_limit_length($session_id, 120);
    if ($session_id !== '') {
        $clean_meta['sessionId'] = $session_id;
    }

    if ($is_gateway_endpoint && $session_id === '') {
        $extra = ['proxy_id' => $proxy_id];
        if ($next_csrf_token !== '') {
            $extra['csrf_token'] = $next_csrf_token;
        }
        ai_chatbot_send_error('session_id wajib diisi untuk endpoint gateway.', 422, $extra);
    }

    $request_id = '';
    if (!empty($clean_meta['requestId'])) {
        $request_id = (string) $clean_meta['requestId'];
    } else {
        $request_id = bin2hex(random_bytes(16));
        $clean_meta['requestId'] = $request_id;
    }

    $owner_id = $clean_meta['ownerId'] ?? ($clean_meta['visitorId'] ?? '');
    $scope = $is_gateway_endpoint ? '' : ($clean_meta['scope'] ?? 'web');
    $entity_id = $is_gateway_endpoint ? '' : ($clean_meta['entityId'] ?? '');
    if (!$is_gateway_endpoint && $entity_id === '' && !empty($clean_meta['pageUrl'])) {
        $entity_id = (string) (parse_url((string) $clean_meta['pageUrl'], PHP_URL_HOST) ?: '');
    }

    $metadata = array_filter([
        'ownerId' => $owner_id,
        'scope' => $scope,
        'entityId' => $entity_id,
        'requestId' => $request_id,
    ], static function ($value) {
        return $value !== '';
    });

    $extra = [
        'wire_chatbot' => false,
    ];
    if ($session_id !== '') {
        $extra['session_id'] = $session_id;
    }
    if (!empty($clean_meta['contact_id'])) {
        $extra['contact_id'] = (string) $clean_meta['contact_id'];
    }
    if (!empty($clean_meta['contact_jid'])) {
        $extra['contact_jid'] = (string) $clean_meta['contact_jid'];
    }

    $handoff_timeout = 0;
    if ($handoff_request) {
        $handoff_route = $route !== '' ? $route : 'handoff';
        if (in_array($handoff_route, ['handoff_off', 'handoff_timeout', 'handoff-off'], true)) {
            ai_chatbot_clear_sse_context($session_id);
        }
        $handoff_timeout = isset($payload['handoff_timeout_sec']) ? (int) $payload['handoff_timeout_sec'] : 0;
        if ($is_gateway_endpoint) {
            if ($handoff_timeout <= 0) {
                $handoff_timeout = 600;
            }
            $handoff_timeout = min(3600, max(60, $handoff_timeout));
        } else {
            if ($handoff_timeout < 0) {
                $handoff_timeout = 0;
            } elseif ($handoff_timeout > 86400) {
                $handoff_timeout = 86400;
            }
        }
        $handoff_reason = isset($payload['handoff_reason'])
            ? ai_chatbot_limit_length((string) $payload['handoff_reason'], 120)
            : '';

        $forward_body = [
            'route' => $handoff_route,
            'handoff' => $handoff_flag || $handoff_route === 'handoff',
            'handoff_timeout_sec' => $handoff_timeout > 0 ? $handoff_timeout : null,
            'handoff_reason' => $handoff_reason,
            'extra' => $extra,
            'metadata' => $metadata,
            'meta' => $clean_meta,
            'timestamp' => time(),
            'proxy_id' => $proxy_id,
        ];

        if ($payload['chatInput'] !== '') {
            $forward_body['chatInput'] = $payload['chatInput'];
            $forward_body['text'] = $payload['chatInput'];
        } elseif ($is_gateway_endpoint) {
            $fallback_message = 'User meminta chat dengan admin.';
            $forward_body['chatInput'] = $fallback_message;
            $forward_body['text'] = $fallback_message;
        }

        if ($session_id !== '') {
            $forward_body['session_id'] = $session_id;
        }
    } else {
        $input_type = isset($payload['inputType']) ? strtolower(trim((string) $payload['inputType'])) : 'text';
        $allowed_types = ['text', 'image', 'document', 'pdf', 'voice'];
        if (!in_array($input_type, $allowed_types, true)) {
            $input_type = 'text';
        }

        $attachments = [];
        if (isset($payload['attachments']) && is_array($payload['attachments'])) {
            $attachments = array_values($payload['attachments']);
            if (count($attachments) > 5) {
                $attachments = array_slice($attachments, 0, 5);
            }
        }
        $payload['inputType'] = $input_type;
        $payload['attachments'] = $attachments;

        $explicit_overrides = isset($proxy_config['explicit_overrides']) && is_array($proxy_config['explicit_overrides'])
            ? $proxy_config['explicit_overrides']
            : [];
        $send_system = !$is_gateway_endpoint || !empty($explicit_overrides['system_prompt']);
        $send_temperature = !$is_gateway_endpoint || !empty($explicit_overrides['temperature']);
        $send_max_tokens = !$is_gateway_endpoint || !empty($explicit_overrides['max_tokens']);

        $system_prompt = trim((string) ($proxy_config['system_prompt'] ?? ''));
        if (!$send_system) {
            $system_prompt = '';
        }

        $temperature = isset($proxy_config['temperature']) ? (float) $proxy_config['temperature'] : 0.7;
        if ($temperature < 0) {
            $temperature = 0;
        } elseif ($temperature > 2) {
            $temperature = 2;
        }

        $max_tokens = isset($proxy_config['max_tokens']) ? (int) $proxy_config['max_tokens'] : 512;
        if ($max_tokens < 16) {
            $max_tokens = 16;
        } elseif ($max_tokens > 4096) {
            $max_tokens = 4096;
        }

        $messages = [];
        if ($system_prompt !== '') {
            $messages[] = [
                'role' => 'system',
                'content' => $system_prompt,
            ];
        }

        foreach ($normalized_history as $item) {
            $role = ($item['sender'] ?? 'user') === 'bot' ? 'assistant' : 'user';
            $messages[] = [
                'role' => $role,
                'content' => $item['text'] ?? '',
            ];
        }
        $messages[] = [
            'role' => 'user',
            'content' => $payload['chatInput'],
        ];

        $body_payload = [
            'chatInput' => $payload['chatInput'],
            'inputType' => $input_type,
            'attachments' => $attachments,
            'text' => $payload['chatInput'],
        ];
        $payload['body'] = $body_payload;

        $forward_body = [
            'messages' => $messages,
            'chatInput' => $payload['chatInput'],
            'text' => $payload['chatInput'],
            'inputType' => $input_type,
            'attachments' => $attachments,
            'body' => $body_payload,
            'extra' => $extra,
            'metadata' => $metadata,
            'input' => $payload['chatInput'],
            'history' => $payload['history'],
            'meta' => $clean_meta,
            'payload' => $payload,
            'timestamp' => time(),
            'proxy_id' => $proxy_id,
        ];
        if ($system_prompt !== '' && $send_system) {
            $forward_body['system'] = $system_prompt;
        }
        if ($send_temperature) {
            $forward_body['temperature'] = $temperature;
        }
        if ($send_max_tokens) {
            $forward_body['max_tokens'] = $max_tokens;
        }

        if ($session_id !== '') {
            $forward_body['session_id'] = $session_id;
        }
    }

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

    if (!empty($metadata['requestId'])) {
        $safe_request_id = str_replace(["\r", "\n"], ' ', (string) $metadata['requestId']);
        $headers[] = 'X-AI-Request-ID: ' . $safe_request_id;
        $headers[] = 'X-Idempotency-Key: ' . $safe_request_id;
    }
    if (!$is_gateway_endpoint && !empty($metadata['scope'])) {
        $headers[] = 'X-AI-Scope: ' . str_replace(["\r", "\n"], ' ', (string) $metadata['scope']);
    }
    if (!$is_gateway_endpoint && !empty($metadata['entityId'])) {
        $headers[] = 'X-AI-Entity: ' . str_replace(["\r", "\n"], ' ', (string) $metadata['entityId']);
    }
    if (!empty($metadata['ownerId'])) {
        $headers[] = 'X-AI-Owner: ' . str_replace(["\r", "\n"], ' ', (string) $metadata['ownerId']);
    }
    if ($session_id !== '') {
        $headers[] = 'X-AI-Session: ' . str_replace(["\r", "\n"], ' ', $session_id);
    }

    ai_chatbot_append_auth_headers($headers, $proxy_config['auth'] ?? ['type' => 'none']);

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
    if ($handoff_request && $is_gateway_endpoint && $handoff_timeout > 0) {
        $timeout = max($timeout, $handoff_timeout + 5);
    }

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

    if (
        isset($decoded['transport']) &&
        is_array($decoded['transport']) &&
        isset($decoded['transport']['mode']) &&
        strtolower((string) $decoded['transport']['mode']) === 'sse'
    ) {
        if (!isset($decoded['transport']['session_id']) || $decoded['transport']['session_id'] === '') {
            $decoded['transport']['session_id'] = $session_id;
        }
        ai_chatbot_store_sse_context($session_id, $decoded['transport']);
    }

    if (
        isset($decoded['transport']) &&
        is_array($decoded['transport']) &&
        isset($decoded['transport']['mode']) &&
        strtolower((string) $decoded['transport']['mode']) === 'ws'
    ) {
        if (!isset($decoded['transport']['session_id']) || $decoded['transport']['session_id'] === '') {
            $decoded['transport']['session_id'] = $session_id;
        }

        $existing_ws_url = '';
        if (!empty($decoded['transport']['ws_url'])) {
            $existing_ws_url = (string) $decoded['transport']['ws_url'];
        } elseif (!empty($decoded['transport']['wsUrl'])) {
            $existing_ws_url = (string) $decoded['transport']['wsUrl'];
        } elseif (!empty($decoded['transport']['url'])) {
            $existing_ws_url = (string) $decoded['transport']['url'];
        }

        if ($existing_ws_url !== '') {
            $decoded['transport']['ws_url'] = $existing_ws_url;
        } else {
            $ws_base = ai_chatbot_gateway_base_url($proxy_config['endpoint'] ?? '');
            if ($ws_base !== '' && empty($decoded['transport']['base_url']) && empty($decoded['transport']['baseUrl'])) {
                $decoded['transport']['base_url'] = $ws_base;
            }
            $ws_url = ai_chatbot_build_ws_url($ws_base, (string) ($decoded['transport']['endpoint'] ?? ''), [
                'session_id' => $decoded['transport']['session_id'],
                'token' => (string) ($decoded['transport']['token'] ?? ''),
            ]);
            if ($ws_url !== '') {
                $decoded['transport']['ws_url'] = $ws_url;
            }
        }
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

function ai_chatbot_plugin_install()
{
    $settings = ai_chatbot_load_config();
    $public_targets = ai_chatbot_parse_footer_targets($settings['chatbot_footer_targets'] ?? '');
    $admin_targets = ai_chatbot_parse_footer_targets($settings['chatbot_footer_targets_admin'] ?? '');
    $targets = array_values(array_unique(array_merge($public_targets, $admin_targets)));

    ai_chatbot_sync_footer_includes(($settings['chatbot_enabled'] ?? '0') === '1', $targets);
}

function ai_chatbot_plugin_uninstall($purge_config = true)
{
    $settings = ai_chatbot_load_config();
    $public_targets = ai_chatbot_parse_footer_targets($settings['chatbot_footer_targets'] ?? '');
    $admin_targets = ai_chatbot_parse_footer_targets($settings['chatbot_footer_targets_admin'] ?? '');
    $targets = array_values(array_unique(array_merge($public_targets, $admin_targets)));

    ai_chatbot_sync_footer_includes(false, $targets);

    if ($purge_config) {
        $keys = ai_chatbot_setting_keys();
        if (!empty($keys)) {
            ORM::for_table('tbl_appconfig')->where_in('setting', $keys)->delete_many();
        }
        if (isset($GLOBALS['config']) && is_array($GLOBALS['config'])) {
            foreach ($keys as $key) {
                unset($GLOBALS['config'][$key]);
            }
        }
    }

    $cache_base = $GLOBALS['CACHE_PATH'] ?? null;
    if ($cache_base) {
        $cache_dir = rtrim($cache_base, DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR . 'ai_chatbot';
        if (is_dir($cache_dir) && class_exists('File')) {
            @File::deleteFolder($cache_dir . DIRECTORY_SEPARATOR);
        }
    }
}

