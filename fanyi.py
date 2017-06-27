#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time           : 17-3-27 上午10:32
# @Author         : Tom.Lee
# @Description    : 
# @File           : fanyi.py
# @Product        : PyCharm

import json
import sys
import logging

import requests

reload(sys)
sys.setdefaultencoding('utf8')

headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    'Cookie': 'BAIDUID=D6BA9FAE7E8326A856C942716774520F:FG=1; '
              'BIDUPSID=D6BA9FAE7E8326A856C942716774520F; '
              'PSTM=1486636295; '
              'BDUSS=HFsS2VwNzlMeWxJUEl3b3ZnYjJjU1BIaXRqeUEyTU9rc1FoenFra1hDQXRzTV'
              'JZSVFBQUFBJCQAAAAAAAAAAAEAAAA~YaJQS2luZ19BcmljAAAAAAAAAAAAAAAAAAAAA'
              'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC0jnVgtI51YZ; '
              'REALTIME_TRANS_SWITCH=1; '
              'FANYI_WORD_SWITCH=1; '
              'HISTORY_SWITCH=1; '
              'SOUND_SPD_SWITCH=1; '
              'SOUND_PREFER_SWITCH=1; '
              'pgv_pvi=9559773184; '
              'pgv_si=s4690999296; '
              'BDRCVFR[Ups602knC30]=I67x6TjHwwYf0; '
              'PSINO=5; '
              'H_PS_PSSID=1449_21119_21803_22037; '
              'locale=zh; '
              'Hm_lvt_64ecd82404c51e03dc91cb9e8c025574=1486702452,1486704354; '
              'Hm_lpvt_64ecd82404c51e03dc91cb9e8c025574=1486708675; '
              'hasSeenTips=1; '
              'to_lang_often=%5B%7B%22value%22%3A%22zh%22%2C%22text%22%3A%22%u'
              '4E2D%u6587%22%7D%2C%7B%22value%22%3A%22en%22%2C%22text%22%3A%22%u82F1%u8BED%22%7D%5D; '
              'from_lang_often=%5B%7B%22value%22%3A%22en%22%2C%22text%22%3A%22%u82F1%u8BED%22%7D%2C%'
              '7B%22value%22%3A%22zh%22%2C%22text%22%3A%22%u4E2D%u6587%22%7D%5D',
    'Host': 'fanyi.baidu.com',
    'Origin': 'http://fanyi.baidu.com',
    'Pragma': 'no-cache',
    'Referer': 'http://fanyi.baidu.com/translate?aldtype=16047&query='
               'does+not+take+keyword+arguments%0D%0A&keyfrom=baidu&smartresult=dict&lang=auto2zh',
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) '
                  'Ubuntu Chromium/50.0.2661.102 Chrome/50.0.2661.102 Safari/537.36',
    'X-Requested-With': 'XMLHttpRequest'
}


def baidu_translate(q='test ok', f='en', t='zh'):
    params = {
        'from': f,
        'to': t,
        'query': q,
        'transtype': 'translang',
        'simple_means_flag': 3
    }

    try:
        data, result = requests.post(
            url='http://fanyi.baidu.com/v2transapi',
            data=params,
            headers=headers,
            timeout=5), []
        if data.status_code == 200:
            content = json.loads(data.content)
            for d in content.get('trans_result').get('data'):
                result.append(d.get('dst'))
        else:
            raise Exception("翻译错误...")
    except:
        raise Exception("请求连接失败...")

    return '\n'.join(result)


if __name__ == '__main__':
    print '请输入要翻译的英文, 回车输入"EOF"结束'
    sentinel = 'EOF'  # 遇到这个就结束
    lines = []
    for line in iter(raw_input, sentinel):
        lines.append(line)

    try:
        res = baidu_translate('\n'.join(lines))
        print '\n[中文翻译结果]：\n%s' % res
    except Exception, e:
        logging.error('翻译服务异常：%s' % e)
