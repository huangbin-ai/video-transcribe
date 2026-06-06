# VideoTranscribe

视频/音频转文字工具。支持本地文件和在线视频（YouTube、B站等）。

## 功能

- **转录**：视频/音频 → 完整文字稿
- **提炼**：从文字稿中提取摘要、笔记或改写内容

## 使用

用户说"帮我转录这个视频"或给出视频链接/文件时，运行：

```bash
./run.sh -i "输入源" [-e gemini|mlx] [-o 输出路径] [--proxy 代理地址]
```

转录完成后询问是否需要进一步提炼。

## 依赖

- Python 3
- yt-dlp（`brew install yt-dlp`）
- ffmpeg（`brew install ffmpeg`）
- google-genai（自动安装）
- GEMINI_API_KEY（环境变量或配置文件）
