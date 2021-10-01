module youtugo

fn parse_video_title(html_text string) ?string {
	start := 7 + html_text.index('<title>') or {
		$if debug {
			eprintln('file : ' + @FILE + ' | line : ' + @LINE + '| ERROR: unable to find the title in the html get repsonse')
		}
		return error('unable to find the title in the html get repsonse')
	}
	end := html_text.index_after('</title>', start)
	return html_text[start..end]
}

fn parse_download_url(html_text string) ?string {
	start := 13 + html_text.index('onClick="G3(\'') or {
		$if debug {
			eprintln('file : ' + @FILE + ' | line : ' + @LINE + '| ERROR: unable to find the download url in the html get response')
		}
		return error('unable to find the download url in the html get response')
	}
	end := html_text.index_after("')", start)
	return html_text[start..end]
}
