# VideoTranscribe

视频/音频转文字工具。字幕优先提取，没有字幕时用 AI 转录。

支持 YouTube、B站、抖音及任何 [yt-dlp 支持的平台](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md)，也支持本地文件。

## 工作原理

```
输入视频 URL 或本地文件
    ↓
第一步：yt-dlp 尝试抓取现成字幕（快、零 API 消耗）
    ↓ 有字幕 → 清洗文本 → 输出
    ↓ 没字幕 ↓
第二步：yt-dlp 下载音频（mp3, 32K）
    ↓
第三步：Gemini 2.5 Flash 或 mlx-whisper 转文字
    ↓
输出到 ~/Downloads/transcript_时间戳.txt
```

## 前置条件

- macOS / Linux
- Python 3
- yt-dlp：`brew install yt-dlp`
- ffmpeg：`brew install ffmpeg`
- Gemini API Key（免费申请）：https://aistudio.google.com/apikey

## 安装

```bash
git clone https://github.com/huangbin-ai/video-transcribe.git
cd video-transcribe
chmod +x run.sh
```

### 配置 API Key（任选一种）

```bash
# 方式 1：环境变量
export GEMINI_API_KEY=你的key

# 方式 2：配置文件
mkdir -p ~/.config/video-transcribe
echo 'GEMINI_API_KEY=你的key' > ~/.config/video-transcribe/.env
```

## 使用

### 基本用法

```bash
# 在线视频
./run.sh -i "https://www.youtube.com/watch?v=xxx"

# B站视频
./run.sh -i "https://www.bilibili.com/video/BVxxx"

# 本地文件
./run.sh -i "video.mp4"
```

### 进阶选项

```bash
# 使用本地引擎（离线，无需 API Key，Apple Silicon 专用）
./run.sh -i "video.mp4" -e mlx

# 指定输出路径
./run.sh -i "video.mp4" -o ~/Desktop/笔记.txt

# 需要代理（访问 YouTube 等）
./run.sh -i "https://youtu.be/xxx" --proxy http://127.0.0.1:1082

# 跳过字幕抓取，强制音频转录
./run.sh -i "https://youtu.be/xxx" --no-subtitle
```

## 转录引擎对比

| 引擎 | 标点 | 网络 | 费用 | 适用场景 |
|------|------|------|------|---------|
| Gemini 2.5 Flash | ✅ 有 | 需要 | 免费额度（1500次/天） | 日常使用（推荐） |
| mlx-whisper | ❌ 无 | 不需要 | 完全免费 | 离线场景、隐私敏感内容 |

## 与 AI Agent 集成

### Claude Code / Codex

放入 `~/.shared-skills/` 目录，用自然语言调用：
> "帮我转录这个视频 https://youtu.be/xxx"

### 命令行直接调用

```bash
python3 Tools/transcribe.py -i "输入源" [选项]
```

## 内容提炼

转录完成后，支持三种提炼模式：

- **快速摘要** — 5-8 条核心观点
- **结构化笔记** — 按主题分层整理
- **内容改写** — 改写为文章 + 推文

详见 [Workflows/Extract.md](Workflows/Extract.md)

## 底层依赖

- [yt-dlp](https://github.com/yt-dlp/yt-dlp) — 视频下载与字幕提取
- [Gemini API](https://ai.google.dev/) — 语音转文字
- [ffmpeg](https://ffmpeg.org/) — 音频提取

## License

MIT
