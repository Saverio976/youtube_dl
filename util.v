module youtube_dl

import net.http { get }

fn parse_video_id(url string) ?string {
	if url.starts_with('https://youtube.com/watch?v=') {
		return url[28..]
	}
	if url.starts_with('https://youtube.com/embed/') {
		return url[26..]
	}
	if url.starts_with('https://youtu.be/') {
		return url[17..]
	}
	return error('unable to find the video id in this link : $url')
}

fn is_valid_url(id string) ?bool {
	url := 'https://www.youtube.com/watch?v=' + id
	$if debug {
		println('GET ' + url)
	}
	r := get(url) or { return err }
	if r.status_code != 200 {
		return error('reveived a $r.status_code status code')
	}
	_ := r.text.index('{') or {
		return error('Non-existant video on youtube')
	}
	return true
}