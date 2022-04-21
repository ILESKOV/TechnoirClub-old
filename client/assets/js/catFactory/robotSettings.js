
var colors = Object.values(allColors())

var defaultId = {
    "element1Color" : 10,
    "element2Color" : 13,
    "element3Color" : 96,
    "element4Color" : 10,
    //Attributes
    "eyesShape" : 3,
    "decorationPattern" : 1,
    "element5Color" : 13,
    "element6Color" : 13,
    "animation" :  1,
    "lastNum" :  1
    }

// when page load
$( document ).ready(function() {
    $('#element1').html(defaultId.element1Color);
    $('#element2').html(defaultId.element2Color);
    $('#element3').html(defaultId.element3Color);
    $('#element4').html(defaultId.element4Color);
      
    $('#eyeshape').html(defaultId.eyesShape)
    $('#decorationShape').html(defaultId.decorationPattern)
    $('#element5').html(defaultId.element5Color)
    $('#element6').html(defaultId.element6Color)
    $('#idanimation').html(defaultId.animation)
    $('#dnaspecial').html(defaultId.lastNum)
  
  renderRobot(defaultId)
  });
  
  function getId(){
      var id = ''
      id += $('#element1').html()
      id += $('#element2').html()
      id += $('#element3').html()
      id += $('#element4').html()
      id += $('#eyesShape').html()
      id += $('#decorationShape').html()
      id += $('#element5').html()
      id += $('#element6').html()
      id += $('#idanimation').html()
      id += $('#dnaspecial').html()
  
      return parseInt(id)
  }
  
  function renderRobot(dna){
     element1Color(colors[dna.element1Color],dna.element1Color)
     $('#element1_color').val(dna.element1Color)
     element2Color(colors[dna.element2Color],dna.element2Color)
     $('#element2_color').val(dna.element2Color)
     element3Color(colors[dna.element3Color],dna.element3Color)
     $('#element3_color').val(dna.element3Color)
     element4Color(colors[dna.element4Color],dna.element4Color)
     $('#element4_color').val(dna.element4Color)
     element5Color(colors[dna.element5Color],dna.element5Color)
     $('#element5_color').val(dna.element5Color)
     element6Color(colors[dna.element6Color],dna.element6Color)
     $('#element6_color').val(dna.element6Color)
     eyeVariation(dna.eyesShape)
     $('#eyeshape').val(dna.eyesShape)
     decorationVariation(dna.decorationPattern)
     $('#decorationshape').val(dna.decorationPattern)
     animationVariation(dna.animation)
     $("#animations").val(dna.animation)
  }
  
  //Settings to separate the color sliders and the attributes sliders.
  $(".btn.robotColors").click(()=>{
    $(".tab.robotColors").css('display', 'block');
    $(".tab.robotAttributes").css('display', 'none');
  })
  
  $(".btn.robotAttributes").click(()=>{
    $(".tab.robotColors").css('display', 'none');
    $(".tab.robotAttributes").css('display', 'block');
  })
  
  // Changing element1 colors
  $('#element1_color').change(()=>{
      var colorVal = $('#element1_color').val()
      element1Color(colors[colorVal],colorVal)
  })
  
  // Changing element2 colors
  $('#element2_color').change(()=>{
    var colorVal = $('#element2_color').val()
    element2Color(colors[colorVal],colorVal)
  })
  
  // Changing element3 colors
  $('#element3_color').change(()=>{
    var colorVal = $('#element3_color').val()
    element3Color(colors[colorVal],colorVal)
  })
  
  // Changing element4 colors
  $('#element4_color').change(()=>{
    var colorVal = $('#element4_color').val()
    element4Color(colors[colorVal],colorVal)
  })
  
  // Changing eyes shape
  $('#eyeshape').change(()=>{
    var shape = parseInt($('#eyeshape').val()) //between 1 and 7
    eyeVariation(shape)
  })
  
  // Changing decoration shape
  $('#decorationshape').change(()=>{
    var shape = parseInt($('#decorationshape').val()) //between 1 and 7
    decorationVariation(shape)
  })
  
  // Changing decoration1 color
  $('#element5_color').change(()=>{
    var colorVal = $('#element5_color').val()
    element5Color(colors[colorVal],colorVal)
  })
  
  // Changing decoration2 color
  $('#element6_color').change(()=>{
    var colorVal = $('#element6_color').val()
    element6Color(colors[colorVal],colorVal)
  })
  
  // Changing decoration2 color
  $('#animations').change(()=>{
    var animationVal = parseInt($('#animations').val())
    animationVariation(animationVal)
  })
  
  // to reload default robot
  $('.default').click(()=>{
    renderRobot(defaultDNA)
  })
  
  // for random color from 10 up to 99 num
  function randomNumber() {
    let random = Math.floor(Math.random()*90)+10
      return random 
  }
  
  // for random attributes from 1 up to 9 num
  function randomNumber1() {
    let random = Math.floor(Math.random()*9)+1
      return random 
  }
  
  function randomRobot(){
  
     let random1 = randomNumber()
     element1Color(colors[random1],random1)
     $('#element1_color').val(random1)
     let random2 = randomNumber()
     element2Color(colors[random2],random2)
     $('#element2_color').val(random2)
     let random3 = randomNumber()
     element3Color(colors[random3],random3)
     $('#element3_color').val(random3)
     let random4 = randomNumber()
     element4Color(colors[random4],random4)
     $('#element4_color').val(random4)
     let random5 = randomNumber()
     element5Color(colors[random5],random5)
     $('#element5_color').val(random5)
     let random6 = randomNumber()
     element6Color(colors[random6],random6)
     $('#element6_color').val(random6)
     let random7 = randomNumber1()
     parseInt(eyeVariation(random7))
     $('#eyeshape').val(random7)
     let random8 = randomNumber1()
     decorationVariation(random8)
     parseInt($('#decorationshape').val(random8))
     let random9 = randomNumber1()
     animationVariation(random9)
     parseInt($("#animations").val(random9))
  }
  
  // for tabs to change from color or attributes
  function openTab(colorAttribute) {
    var i;
    var x = document.getElementsByClassName("tab");
    for (i = 0; i < x.length; i++) {
      x[i].style.display = "none";  
    }
    document.getElementById(colorAttribute).style.display = "block";  
  }
  
  //Showing Colors and Cattribute Boxes

function showColors(){
  $('#robotColors').removeClass('hidden')
  $('#robotAttributes').addClass('hidden')
}

function showAttributes(){
  $('#robotAttributes').removeClass('hidden')
  $('#robotColors').addClass('hidden')
}