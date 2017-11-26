var pixels = []

for (var i = 0; i <= 2600; i++) {
  var thisPixel = document.createElement("div");
  pixels.push(thisPixel);
  var brightness = Math.random() /2 + 0.5;
  var sourceColor = "#663399"
  thisPixel.className = "pixel";
  document.getElementById("background").appendChild(thisPixel);
  thisPixel.style.backgroundColor = adjustBrightness(sourceColor, brightness)
}

animateBackground();

function animateBackground() {
  var thisPixel;
  setInterval(function() {    
    for (var i = 0; i < 50; i++) {
      thisPixel = pixels[Math.floor(Math.random() * pixels.length)]
      thisPixel.className += " twinkle";
      thisPixel.addEventListener('animationend', function(){
        this.className = "pixel";
      });
    }
  }, 5000/3);
}

function adjustBrightness(originalColor, adjustment) {
  var rgbColor = null;
  if (isHexColor(originalColor)) {
    rgbColor = hexToRGB(originalColor);
  } else if (isRGBColor(originalColor)) {
    var rgbArray = originalColor.match(/\d+/g);
    rgbColor = {
      red: rgbArray[0],
      green: rgbArray[1],
      blue: rgbArray[2]
    };
  }

  if (rgbColor) {
    var newColor = {
      red: clamp(Math.floor(rgbColor.red * adjustment)),
      green: clamp(Math.floor(rgbColor.green * adjustment)),
      blue: clamp(Math.floor(rgbColor.red * adjustment))
    }
    return "rgb(" + newColor.red + ", " + newColor.green + ", " + newColor.blue + ")";
  }

}

function isHexColor(color) {
  return color.match(/#((\w{6})|(\w{3}))/);
}

function isRGBColor(color) {
  return color.match(/rgb\s?\(\s?\d+\s?,\s?\d+\s?,\s?\d+\s?\)/)
}

function hexToRGB(originalColor) {
  var vals = originalColor.match(/\w+/)[0];
  var retVal = {};
  if (vals.length === 3) {
    vals = vals[0] + vals[0] + vals[1] + vals[1] + vals[2] + vals[2];
  }
  retVal.red = hexToDec(vals.substr(0, 2));
  retVal.green = hexToDec(vals.substr(2, 2));
  retVal.blue = hexToDec(vals.substr(4, 2));

  return retVal;
}

function hexToDec(hexNum) {
  return parseInt(hexNum, 16);
}

function decToHex(decNum) {
  return decNum.toString(16);
}

function clamp(val) {
  if (val < 0) return 0;
  if (val > 255) return 255;
  return val;
}
