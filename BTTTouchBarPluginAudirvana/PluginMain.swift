import Foundation
import AppKit
@objc class PluginMain : NSObject, BTTPluginInterface
{
    // the delegate will be set automatically after this plugin is loaded in BTT
    var delegate : BTTTouchBarPluginDelegate?


    var customVC: PluginViewController?;
    var configurationValues: Dictionary<AnyHashable, Any> = [:];


    /* MARK: Option 3: Returning a NSViewController instance
     * if you return a view controller BTT will display the view
     * controller's view on
     * the Touch Bar.
     * You are responsible for any styling you want to apply.
     * Make sure to always return the same instance of the button
     * here.
     */
    func touchBarViewController() -> NSViewController? {
        if(self.customVC == nil) {
           
            self.customVC = PluginViewController.init()
            self.configure()

        }
        return self.customVC;
    }


    func configure() {
        if((self.configurationValues["plugin_var_isSeekBarMode"]) != nil) {
            let mode = self.configurationValues["plugin_var_isSeekBarMode"]
            Configuration.shared.isSeekBarMode = mode as! Bool
        }
        if((self.configurationValues["plugin_var_isSystemMediaMode"]) != nil) {
            let mode = self.configurationValues["plugin_var_isSystemMediaMode"]
            Configuration.shared.isSystemMediaMode = mode as! Bool
        }
    }

    // here you can configure what items are shown in the BTT configuration side-bar for this plugin
    class func configurationFormItems() -> BTTPluginFormItem? {

        // here we just create a text field, we will receive the
        // current value in didReceiveNewConfigurationValues
        let groupNowPlaying = BTTPluginFormItem.init()
        groupNowPlaying.formFieldType = BTTFormTypeFormGroup
        
//        let modeMenu = BTTPluginFormItem.init()
//        modeMenu.formFieldType = BTTFormTypePopupButton
//        modeMenu.formFieldID = "plugin_var_mode"
//        modeMenu.formLabel1 = "表示モード"
//
//        let itemNowPlaying = BTTPluginFormItem.init()
//        itemNowPlaying.formFieldType = BTTFormTypeTitleField
//        itemNowPlaying.formFieldID = "plugin_var_nowplaying"
//        itemNowPlaying.formLabel1 = "NowPlaying"
//
//        let itemSeekBar = BTTPluginFormItem.init()
//        itemSeekBar.formFieldType = BTTFormTypeTitleField
//        itemSeekBar.formFieldID = "plugin_var_seekbar"
//        itemSeekBar.formLabel1 = "SeekBar"
//
//        modeMenu.formOptions = [itemNowPlaying, itemSeekBar]
        
        let systemMediaCheckbox = BTTPluginFormItem.init()
        systemMediaCheckbox.formFieldType = BTTFormTypeCheckbox
        systemMediaCheckbox.formFieldID = "plugin_var_isSystemMediaMode"
        systemMediaCheckbox.formLabel1 = "SystemMediaから情報取得 (実験的機能 不具合多数あり)"
        
        
        let seekbarCheckbox = BTTPluginFormItem.init()
        seekbarCheckbox.formFieldType = BTTFormTypeCheckbox
        seekbarCheckbox.formFieldID = "plugin_var_isSeekBarMode"
        seekbarCheckbox.formLabel1 = "SeekBarとして表示 (SeekBar Mode)"
        
        groupNowPlaying.formOptions = [systemMediaCheckbox, seekbarCheckbox]
        
        return groupNowPlaying
    }

    func didReceiveNewConfigurationValues(_ configurationValues: [AnyHashable : Any]) {
        self.configurationValues = configurationValues
        if (self.customVC != nil) {
            self.configure();
        }
    }

    // this will tell BTT to execute the actions the user assigned to this widget
    @objc func executeAssignedBTTActions() {
        self.delegate?.executeAssignedBTTActions(self)
    }

}

