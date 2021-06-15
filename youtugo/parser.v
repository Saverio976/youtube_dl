module youtugo

fn parse_video_title(html_text string) ?string {
	start := 7 + html_text.index('<title>') or { 
		eprintln('unable to find title')
		return none 
	}
	end := html_text.index_after('</title>', start)
	return html_text[start..end]
}

fn parse_download_url(html_text string) ?string {
	start := 13 + html_text.index('onClick="G3(\'') or { 
		eprintln('unable to find download link')
		return none 
	}
	end := html_text.index_after("')", start)
	return html_text[start..end]
}
