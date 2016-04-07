
/*
 * $Id
 */

/*
 * FivePhone source code:
 * UIImageView support
 *
 * Copyright 2010 Antonio Linares <alinares@fivetechsoft.com>
 * www - http://www.fivetechsoft.com
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307 USA (or visit the web site http://www.gnu.org/).
 *
 * As a special exception, this project gives permission for
 * additional uses of the text contained in the release of Harbour.
 *
 * The exception is that, if you link these libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking this library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by this
 * Project under the name FivePhone.  If you copy code from other
 * projects or Free Software Foundation releases into this project,
 * as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for FivePhone, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */

#import <UIKit/UIKit.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

HB_FUNC( CREATEIMAGEVIEW )
{
   UIView * parent   = ( UIView * ) hb_parnl( 1 );
   NSString * cImage = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];
   UIImage * image   = [ [ UIImage imageNamed : cImage ] autorelease ];
   UIImageView * imgView = [ [ UIImageView alloc ] initWithImage : image ];
   
   [ imgView setFrame : CGRectMake( hb_parnl( 3 ), hb_parnl( 4 ), image.size.width, image.size.height ) ];
   
   [ parent addSubview : imgView ];
   
   hb_retnl( ( LONG ) imgView );
}   


HB_FUNC( IMAGEVIEWCENTERNSSTRING )
{
 UIImageView * imgView  = (  UIImageView * ) hb_parnl( 1 );
 CGPoint pt =  CGPointFromString ( (NSString *) hb_parnl( 2 ) ) ;
 imgView.center = pt ;
}


HB_FUNC( IMAGEVIEWCENTER )
{
	UIImageView * imgView  = (  UIImageView * ) hb_parnl( 1 );
	CGPoint pt =  CGPointMake ( hb_parnd( 2 ), hb_parnd( 3 ) ) ;
	imgView.center = pt ;
}




HB_FUNC( CREATEIMAGEVIEWRESOURCES )
{
   UIImageView * imgView  = (  UIImageView * ) hb_parnl( 1 );
   NSString * cImage = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];
   UIImage * image   = [ [ UIImage imageNamed : cImage ] autorelease ];
	imgView.image  =  image   ;
     
}   


void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
	float fw, fh;
	if (ovalWidth == 0 || ovalHeight == 0) {
		CGContextAddRect(context, rect);
		return;
	}

	CGContextSaveGState(context);
	CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextScaleCTM (context, ovalWidth, ovalHeight);
	fw = CGRectGetWidth (rect) / ovalWidth;
	fh = CGRectGetHeight (rect) / ovalHeight;
	CGContextMoveToPoint(context, fw, fh/2);
	CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
	CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
	CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
	CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
	CGContextClosePath(context);
    CGContextRestoreGState(context);
}


CGImageRef CreateGradientImage(int pixelsWide, int pixelsHigh)
{
	CGImageRef theCGImage = NULL;
	
	// gradient is always black-white and the mask must be in the gray colorspace
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
	
	// create the bitmap context
	CGContextRef gradientBitmapContext = CGBitmapContextCreate(NULL, pixelsWide, pixelsHigh,
															   8, 0, colorSpace, kCGImageAlphaNone);
	
	// define the start and end grayscale values (with the alpha, even though
	// our bitmap context doesn't support alpha the gradient requires it)
	CGFloat colors[] = {0.0, 1.0, 1.0, 1.0};
	
	// create the CGGradient and then release the gray color space
	CGGradientRef grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
	CGColorSpaceRelease(colorSpace);
	
	// create the start and end points for the gradient vector (straight down)
	CGPoint gradientStartPoint = CGPointZero;
	CGPoint gradientEndPoint = CGPointMake(0, pixelsHigh);
	
	// draw the gradient into the gray bitmap context
	CGContextDrawLinearGradient(gradientBitmapContext, grayScaleGradient, gradientStartPoint,
								gradientEndPoint, kCGGradientDrawsAfterEndLocation);
	CGGradientRelease(grayScaleGradient);
	
	// convert the context into a CGImageRef and release the context
	theCGImage = CGBitmapContextCreateImage(gradientBitmapContext);
	CGContextRelease(gradientBitmapContext);
	
	// return the imageref containing the gradient
    return theCGImage;
}


CGContextRef MyCreateBitmapContext(int pixelsWide, int pixelsHigh)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	// create the bitmap context
	CGContextRef bitmapContext = CGBitmapContextCreate (NULL, pixelsWide, pixelsHigh, 8,
														0, colorSpace,
														// this will give us an optimal BGRA format for the device:
														(kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
	CGColorSpaceRelease(colorSpace);
	
    return bitmapContext;
}


HB_FUNC( CREATEIMAGE )
{
	NSString * cImage = [ [ [ NSString alloc ] initWithCString: ISCHAR( 1 ) ? hb_parc( 1 ) : "" ] autorelease ];
	UIImage * image   = [ [ UIImage imageNamed : cImage ] autorelease ];
	hb_retnl( ( LONG ) image );
}   


HB_FUNC( IMAGETOROUNDIMAGE )
{
	UIImage * source  = ( UIImage * ) hb_parnl( 1 );
	
	int w = source.size.width;
	int h = source.size.height;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
	
	CGContextBeginPath(context);
	CGRect rect = CGRectMake(0, 0, w, h);
	addRoundedRectToPath(context, rect, 5, 5);
	CGContextClosePath(context);
	CGContextClip(context);
	
	CGContextDrawImage(context, CGRectMake(0, 0, w, h), source.CGImage);
	
	CGImageRef imageMasked = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	
	
 hb_retnl( ( LONG )  [UIImage imageWithCGImage:imageMasked] ) ;

}


HB_FUNC( IMAGEREFLESFROMIMAGEVIEW )
{
	UIImageView * imgView = ( UIImageView * ) hb_parnl( 1 );
	
	
	// create a bitmap graphics context the size of the image
	CGContextRef mainViewContentContext = MyCreateBitmapContext(imgView.bounds.size.width, hb_parnl( 2 ));
	
	// create a 2 bit CGImage containing a gradient that will be used for masking the 
	// main view content to create the 'fade' of the reflection.  The CGImageCreateWithMask
	// function will stretch the bitmap image as required, so we can create a 1 pixel wide gradient
	CGImageRef gradientMaskImage = CreateGradientImage(1, hb_parnl( 2 ));
	
	// create an image by masking the bitmap of the mainView content with the gradient view
	// then release the  pre-masked content bitmap and the gradient bitmap
	CGContextClipToMask(mainViewContentContext, CGRectMake(0.0, 0.0, imgView.bounds.size.width, hb_parnl( 2 )), gradientMaskImage);
	CGImageRelease(gradientMaskImage);
	
	// In order to grab the part of the image that we want to render, we move the context origin to the
	// height of the image that we want to capture, then we flip the context so that the image draws upside down.
	CGContextTranslateCTM(mainViewContentContext, 0.0, hb_parnl( 2 ));
	CGContextScaleCTM(mainViewContentContext, 1.0, -1.0);
	
	// draw the image into the bitmap context
	CGContextDrawImage(mainViewContentContext, imgView.bounds, imgView.image.CGImage);
	
	// create CGImageRef of the main view bitmap content, and then release that bitmap context
	CGImageRef reflectionImage = CGBitmapContextCreateImage(mainViewContentContext);
	CGContextRelease(mainViewContentContext);
	
	// convert the finished reflection image to a UIImage 
	UIImage *theImage = [UIImage imageWithCGImage:reflectionImage];
	
	// image is retained by the property setting above, so we can release the original
	CGImageRelease(reflectionImage);
	
	hb_retnl( ( LONG )  theImage );
}

HB_FUNC( CREATEIMAGEFROMIMAGEVIEW )
{
	UIImageView * imgView = ( UIImageView * ) hb_parnl( 1 );
	
	hb_retnl( ( LONG ) [ imgView image] );
}  




HB_FUNC( CREATEIMAGEVIEWFROMIMAGE )
{
	UIView * parent   = ( UIView * ) hb_parnl( 1 );
	UIImage * image   = (UIImage *) hb_parnl( 2 ) ;
	UIImageView * imgView = [ [ UIImageView alloc ] initWithImage : image ];
	
	[ imgView setFrame : CGRectMake( hb_parnl( 3 ), hb_parnl( 4 ), image.size.width, image.size.height ) ];
	
	[ parent addSubview : imgView ];
	
	hb_retnl( ( LONG ) imgView );
}  


HB_FUNC( ADDIMAGEVIEWANIMATE )
{
	UIImageView * imgView = ( UIImageView * ) hb_parnl( 1 );
  NSMutableArray * items = [ [ NSMutableArray alloc ] init ];
  
  int n;

   
	 for( n = 1; n <= hb_parinfa( 2, 0 ); n++ )
	{
	 NSString * cImage = [ [ [ NSString alloc ] initWithCString: hb_parvc( 2, n )  ] autorelease ];
     UIImage * image   = [ [ UIImage imageNamed : cImage ] autorelease ];
		
	[ items addObject : image ];
	
	} 
			
  imgView.animationImages = items ;
		
} 


HB_FUNC( STARTIMAGEVIEWANIMATE )
{
	UIImageView * imgView = ( UIImageView * ) hb_parnl( 1 );
	[ imgView startAnimating ] ;
	
} 

HB_FUNC( DURATIONIMAGEVIEWANIMATE )
{
	UIImageView * imgView = ( UIImageView * ) hb_parnl( 1 );
	imgView.animationDuration =hb_parnl( 2 )/100 ;
} 

HB_FUNC( REPEATIMAGEVIEWANIMATE )
{
	UIImageView * imgView = ( UIImageView * ) hb_parnl( 1 );
	 imgView.animationRepeatCount = hb_parnl( 2 );
} 

HB_FUNC( STOPIMAGEVIEWANIMATE )
{
	UIImageView * imgView = ( UIImageView * ) hb_parnl( 1 );
	[ imgView stopAnimating ];
} 

HB_FUNC( ISIMAGEVIEWANIMATE )
{
	UIImageView * imgView = ( UIImageView * ) hb_parnl( 1 );
	hb_retl( imgView.isAnimating ) ;
} 


HB_FUNC( IMAGEVIEWSCALE )
{
UIImageView * imgView = ( UIImageView * ) hb_parnl( 1 );
imgView.transform = CGAffineTransformScale(imgView.transform, hb_parnd( 2 ), hb_parnd( 2 ));
}




HB_FUNC( CREATEURLIMAGEVIEW )
{
   UIView * parent   = ( UIView * ) hb_parnl( 1 );
   NSString *cImage = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];
   NSURL *url = [[NSURL URLWithString: cImage ]autorelease ];
  
   UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL:url]]autorelease ]; 
   UIImageView * imgView = [ [ UIImageView alloc ] initWithImage : image ];
   
   [ imgView setFrame : CGRectMake( hb_parnl( 3 ), hb_parnl( 4 ), image.size.width, image.size.height ) ];
   
   [ parent addSubview : imgView ];
   
   hb_retnl( ( LONG ) imgView );
}   
