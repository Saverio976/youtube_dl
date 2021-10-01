# v youtube_dl

### v module to download video or audio of youtube (uses youtugo.com and yt-download.org)

# examples

```v
import youtube_dl

fn main(){
	url := 'https://youtube.com/watch?v=YykjpeuMNEk'
	folder := '.'
	path := youtube_dl.download_audio(url, folder) or { return }
	println('the audio is in ${folder}/${path}')
}
```
you can change `download_audio` with `download_video` to download not only the audio.


# module 

## Contents
- [download_audio](#download_audio)
- [download_video](#download_video)

## download_audio
```v
fn download_audio(url string, dir string) ?string
```

download_audio download the audio (mp3) of the given <url> in the <dir> directory 

[[Return to contents]](#Contents)

## download_video
```v
fn download_video(url string, dir string) ?string
```

download_video download the video (mp4) of the given <url> in the <dir> directory 

[[Return to contents]](#Contents)

#### Powered by vdoc. Generated on: 1 Oct 2021 18:18:12
