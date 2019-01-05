ls | ForEach-Object {
if ($_.Name -match '([0-9]+)._([0-9]+).+jpg'){
 #
 $hour = $Matches[1];
 $sec = $Matches[2];
 $min = [math]::Floor($sec / 60);
 $sec = $sec % 60;
 $str = Get-Date -Date "2019年1月5日" -Format "yyyy':'MM':'dd HH':'mm':'ss" -Hour $hour -Minute $min -Second $sec;
 #
 $img = [System.Drawing.Image]::Fromfile($_.FullName);
 $ppt = $img.GetPropertyItem($img.PropertyIdList[0]);
 $ppt.id = 36867; $ppt.Len = 20; $ppt.Type = 2;
 $ppt.Value = ($str+"`0").ToCharArray();
 $img.SetPropertyItem($ppt);
 $ppt.id = 36868;
 $img.SetPropertyItem($ppt);
 $img.Save($_.FullName+'.new');
 $img.Dispose();
 mv ($_.FullName+'.new') $_.FullName -Force;
 #
 $_.Name
 }
}