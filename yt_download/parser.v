module yt_download

fn parse_video_title(html_text string) ?string {
	start := 10 + html_text.index('{"title":') or {
		eprintln('unable to find video title')
		return none
	}
	end := html_text.index_after('","', start)
	return html_text[start..end]
}

fn parse_best_audio_download_url(html_text string) ?string {
	start_i := html_text.index('<div class="download') or {
		eprintln('unable to find dowload link')
		return none
	}
	start := 9 + html_text.index_after('<a href=', start_i)
	end := html_text.index_after('" class=', start)
	return html_text[start..end]
}

fn parse_video_download_url(html_text string) ?string {
	start_i := html_text.index('<div class="download') or {
		eprintln('unable to find dowload link')
		return none
	}
	start := 9 + html_text.index_after('<a href=', start_i)
	end := html_text.index_after('" class=', start)
	return html_text[start..end]
}
