<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Random Embedded YouTube Video</title>
</head>
<body>

    <div style="text-align: center; margin-bottom: 20px;">
        <h1 style="font-size: 1em;">Go play Roblox Filtering Disabled :P</h1>
    </div>

    <div style="max-width: 800px; margin: 0 auto;">
        <?php
            $videoList = array(
                "https://www.youtube.com/embed/ybZR-rITalI",
                "https://www.youtube.com/embed/WL4Dbxn4CoA",
                "https://www.youtube.com/embed/s0VbrReYiJA",
                "https://www.youtube.com/embed/cDj2r8QEzzk",
            );

            // Select a random video URL from the list
            $randomVideoUrl = $videoList[array_rand($videoList)];
        ?>

        <!-- Embed the random video using an iframe with a larger height -->
        <iframe id="randomVideo" width="100%" height="1000" src="<?php echo $randomVideoUrl; ?>" frameborder="0" allowfullscreen></iframe>

        <script>
            // JavaScript to change the video URL on page refresh
            document.getElementById('randomVideo').src = '<?php echo $randomVideoUrl; ?>';
        </script>
    </div>

</body>
</html>
