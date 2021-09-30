module yt_download

fn parse_video_title(html_text string) ?string {
	start := 7 + html_text.index('<title>')or {
		$if debug {
			eprintln('file : ' + @FILE + ' | line : ' + @LINE + '| ERROR: unable to find the title in the html get repsonse')
		}
		return error('unable to find the title in the html get repsonse')
	}
	end := html_text.index_after('</title>', start)
	return html_text[start..end].trim_right('- YouTube')
}

fn parse_best_audio_download_url(html_text string) ?string {
	start_i := html_text.index('<div class="download') or {
		$if debug {
			eprintln('file : ' + @FILE + ' | line : ' + @LINE + '| ERROR: unable to find the download url in the html get response')
		}
		return error('unable to find the download url in the html get response')
	}
	start := 9 + html_text.index_after('<a href=', start_i)
	end := html_text.index_after('" class=', start)
	return html_text[start..end]
}

fn parse_video_download_url(html_text string) ?string {
	start_i := html_text.index('<div class="download') or {
		$if debug {
			eprintln('file : ' + @FILE + ' | line : ' + @LINE + '| ERROR: unable to find the download url in the html get response')
		}
		return error('unable to find the download url in the html get response')
	}
	start := 9 + html_text.index_after('<a href=', start_i)
	end := html_text.index_after('" class=', start)
	return html_text[start..end]
}
