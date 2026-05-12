if (os_browser != browser_not_a_browser) {
    if (browser_width != window_get_width() || browser_height != window_get_height()) {
        game_set_window(); // Re-executa a sua função de ajuste
    }
}