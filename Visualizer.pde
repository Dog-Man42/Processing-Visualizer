import com.hamoid.*;

import processing.sound.*;

Amplitude ampl;
FFT fft;
SoundFile file;
SoundFile file2;
AudioIn in;
AudioIn in2;

int bands = 512;
float[] spectrum = new float[bands];
float band;
float max;
int HZ;
float amp;
int space = 0;
float ampnoise;
String input = "Name Of File Here";
float centerx;
float centery;
float value;

void setup() {
  frameRate(60);
  size(1280, 720);
  //fullScreen();
  background(255);
  centerx = width/2;
  centery = height/2;
  // this is for file input  

  fft = new FFT(this, bands);

  file = new SoundFile(this, input);
  ampl = new Amplitude(this);
  println("SFSampleRate= " + file.sampleRate() + " Hz");
  //file.rate(.5);
  file.play();
  ampl.input(file);
  fft.input(file);
  background(0);

  ////this is for mic input

  //  fft = new FFT(this, bands);
  //  in = new AudioIn(this, 0);
  //  ampl = new Amplitude(this);
  ////println("SFSampleRate= " + file.sampleRate() + " Hz");
  ////file.rate(.5);
  //  in.start();
  //  ampl.input(in);
  //  fft.input(in);
  //  background(0);
}      

void draw() { 

  //rectMode(CORNERS);
  clear();
  fft.analyze(spectrum);
  max = max(spectrum);

  for (int i = 0; i < bands; i++) {
    if ( spectrum[i] == max) {
      band = i;
      break;
    }
  }

  //println(band);
  //println("amp",ampl.analyze() * 500);
  //println("band",band*5);
  //println("max",max*1000);

  amp = ampl.analyze();

  fill(round(ampl.analyze() * 250), band*5, max*1500);
  //fill(round(ampl.analyze() * 200),max*band*amp*250,band*amp*20,255);

  ellipse(centerx, centery, amp * 200, amp * 200);

  fill(round(ampl.analyze() * 200), max*band * amp * 250, band * amp * 20);

  value =  max * band * amp * ampnoise * 25;

  ellipse( centerx + ( ampnoise * 1000 * amp * round(random(-1, 1))), centery + ( ampnoise * 1000 * amp * round(random(-1, 1))), value, value );

  ampnoise = noise(amp);

  for (int x = 0; x <= 8; x++) {
    fill(amp * 500, max*band*amp*200, band*amp*75, 100);

    value = ampnoise * 2 * ((amp /( amp * amp )) * 10);

    ellipse( centerx + ( ampnoise * 100 * round(random(-1, 1))) * (1/(max * 20)), centery + (ampnoise * 100 * round(random(-1, 1))) * ( 1 / (max * 20)), value, value);

    fill(amp * band * 150 * ampnoise , max * band * amp * ampnoise * 500 , band * amp * 1 * ampnoise,255/5);

    value = max * band * amp * ampnoise * 100;
    
    ellipse( width/2 + (ampnoise*900*amp * round(random(-1,1))),height/2 + (ampnoise*900*amp * round(random(-1,1))), value, value );

     fill(amp * band * 150 * ampnoise ,band*5,max*band*50,255);

    ellipse(width / 2 + (noise( max * band) * 500 * round( random(-1,1))),height / 2 + (noise(amp * max) * 500 * round( random(-1,1))), amp * 50 , max * 40 );
  }

  fill(round(ampl.analyze() * 100),max*band*amp*250,band*amp*50,255);
  ellipse(width/2 + noise(band)*amp*random(-1,1),height/2 + noise(max)*amp*random(-1,1),amp*200,max*200);
}
