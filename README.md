# sakunoki-downloader

ラジオ番組 [BayFM 今夜、咲良の木の下で](http://web.bayfm.jp/saku/) オンデマンドダウンローダです。

来週もこの時間に咲良の木の下で、あなたをダウンロードします！

## News

## ⚠️ Warning

Sakunoki is being aired every Wednesday 24:00, the on-demand version is uploaded in a couple of hours (which is thursday). And the on-demand filenames follow `miyawaki-<date_aired>.mp3` pattern. The script will replace `date_aired` as "1 day before its execution date" with the assumption that you run this script on thursday. You can, however, set a specific date by passing it as the first argument of the script (See start guide blow).

## Getting Started

### Requirements

- [IFTTT Webhooks](https://ifttt.com/maker_webhooks) (event name, key)
- ~~WIZ*ONE Membership~~

### Step 1 - Set Variables

```shell script
export DL_DIR="</path/to/download/directory>"
export WEBHOOK_TRIGGER="<event name>"
export WEBHOOK_KEY="<key>"
```

### Step 2 - Run

```shell script
chmod u+x download_sakunoki.sh
./download_sakunoki.sh
```

#### Example of Event Results

```text
[sakunoki] miyawaki-20200219.mp3 downloaded (12MB)
```
or, you can specify a specific date being aired:
```shell script
./download_sakunoki.sh 20200219
```
