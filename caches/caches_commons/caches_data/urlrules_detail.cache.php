<?php
return array (
  1 => 
  array (
    'urlruleid' => '1',
    'module' => 'content',
    'file' => 'category',
    'ishtml' => '1',
    'urlrule' => '{$catdir}/index.html|{$catdir}/_{$page}.html',
    'example' => 'news/',
  ),
  18 => 
  array (
    'urlruleid' => '18',
    'module' => 'content',
    'file' => 'show',
    'ishtml' => '1',
    'urlrule' => '{$catdir}/{$id}.html|{$catdir}/{$id}{$page}.html',
    'example' => 'news/1.html',
  ),
);
?>