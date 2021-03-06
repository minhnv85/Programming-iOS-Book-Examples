
import UIKit

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
extension CGSize {
    init(_ width:CGFloat, _ height:CGFloat) {
        self.init(width:width, height:height)
    }
}
extension CGPoint {
    init(_ x:CGFloat, _ y:CGFloat) {
        self.init(x:x, y:y)
    }
}
extension CGVector {
    init (_ dx:CGFloat, _ dy:CGFloat) {
        self.init(dx:dx, dy:dy)
    }
}
extension CGRect {
    var center : CGPoint {
        return CGPoint(x:self.midX, y:self.midY)
    }
}


class ViewController : UIViewController {
    var anim : UIDynamicAnimator!
    var att : UIAttachmentBehavior!
    
    @IBAction func dragging(_ p: UIPanGestureRecognizer) {
        switch p.state {
        case .began:
            self.anim = UIDynamicAnimator(referenceView:self.view)
            self.anim.delegate = self
            let loc = p.location(ofTouch:0, in:p.view)
            let cen = p.view!.bounds.center
            let off = UIOffset(horizontal: loc.x-cen.x, vertical: loc.y-cen.y)
            let anchor = p.location(ofTouch:0, in:self.view)
            let att = UIAttachmentBehavior(item:p.view!,
                offsetFromCenter:off, attachedToAnchor:anchor)
            self.anim.addBehavior(att)
            self.att = att
        case .changed:
            self.att.anchorPoint = p.location(ofTouch:0, in: self.view)
        default:
            print("done")
            self.anim = nil
        }
    }
}

extension ViewController : UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        print("pause")
    }
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
        print("resume")
    }

}

// unused code
/*

- (IBAction)panning:(UIPanGestureRecognizer*)g {
if (g.state == UIGestureRecognizerStateBegan) {
self.anim = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
self.anim.delegate = self;

self.atts = [NSMutableArray new];
CGRect r = CGRectInset(g.view.frame, -20, -20);
CGRect f = g.view.frame;
CGPoint cen = g.view.center;
CGFloat damp = 0.95;
CGFloat freq = 200;

CGPoint p;
UIOffset off;
UIAttachmentBehavior* att;

p = CGPoint(CGRectGetMinX(r), CGRectGetMinY(r));
off = UIOffsetMake(CGRectGetMinX(f)-cen.x, CGRectGetMinY(f)-cen.y);
att = [[UIAttachmentBehavior alloc] initWithItem:g.view offsetFromCenter:off attachedToAnchor:p];
att.damping = damp; att.frequency = freq;
[self.anim addBehavior:att];
[self.atts addObject: att];

p = CGPoint(CGRectGetMaxX(r), CGRectGetMaxY(r));
off = UIOffsetMake(CGRectGetMaxX(f)-cen.x, CGRectGetMaxY(f)-cen.y);
att = [[UIAttachmentBehavior alloc] initWithItem:g.view offsetFromCenter:off attachedToAnchor:p];
att.damping = damp; att.frequency = freq;
[self.anim addBehavior:att];
[self.atts addObject: att];

p = CGPoint(CGRectGetMaxX(r), CGRectGetMinY(r));
off = UIOffsetMake(CGRectGetMaxX(f)-cen.x, CGRectGetMinY(f)-cen.y);
att = [[UIAttachmentBehavior alloc] initWithItem:g.view offsetFromCenter:off attachedToAnchor:p];
att.damping = damp; att.frequency = freq;
[self.anim addBehavior:att];
[self.atts addObject: att];

p = CGPoint(CGRectGetMinX(r), CGRectGetMaxY(r));
off = UIOffsetMake(CGRectGetMinX(f)-cen.x, CGRectGetMaxY(f)-cen.y);
att = [[UIAttachmentBehavior alloc] initWithItem:g.view offsetFromCenter:off attachedToAnchor:p];
att.damping = damp; att.frequency = freq;
[self.anim addBehavior:att];
[self.atts addObject: att];



}
else if (g.state == UIGestureRecognizerStateChanged) {
CGPoint delta = [g translationInView: g.view.superview];
for (UIAttachmentBehavior* att in self.atts) {
CGPoint p = att.anchorPoint;
p.x += delta.x; p.y += delta.y;
att.anchorPoint = p;
}
[g setTranslation: CGPoint.zero inView: g.view.superview];
}

else {
NSLog(@"%f %f %f", self.att.length, self.att.damping, self.att.frequency);
self.atts = nil;
self.anim = nil;
g.view.transform = CGAffineTransformIdentity;
}
}

*/

