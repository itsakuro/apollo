//
//  EditLyricsView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/29/26.
//

import SwiftUI

struct EditLyricsView: View {
    @Binding var lyrics: String
    
    var body: some View {
        ZStack {
            Color.Backgrounds.primary.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 28) {
                    Button {
                        print("Open from TTML")
                    } label: {
                        HStack(spacing: 2) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Add from .ttml file")
                                    .fontWeight(.bold)
                                
                                Text("Import time-synced lyrics")
                                    .foregroundStyle(Color.Labels.secondary)
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(ImageResource.chevronRight)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .foregroundStyle(Color.Labels.secondary.opacity(0.5))
                        }
                        .padding()
                        .background(Color.Backgrounds.secondary)
                        .clipShape(.rect(cornerRadius: 26))
                    }
                    
                    TextField("", text: $lyrics, prompt: Text("Tap to add lyrics...").foregroundStyle(Color.Labels.secondary.opacity(0.5)), axis: .vertical)
                        .frame(maxHeight: .infinity)
                }
            }
            .contentMargins(.horizontal, 24)
            .contentMargins(.vertical, 16)
        }
        .fontWeight(.medium)
        .fontDesign(.rounded)
        .foregroundStyle(Color.Labels.primary)
    }
}

#Preview {
    EditLyricsView(lyrics: .constant("Oh god, it's just so hard to know"))
}

// .TTML file example
//<tt xmlns="http://www.w3.org/ns/ttml" xmlns:ttm="http://www.w3.org/ns/ttml#metadata"
//    xmlns:tts="http://www.w3.org/ns/ttml#styling" xmlns:amll="http://www.example.com/ns/amll"
//    xmlns:itunes="http://music.apple.com/lyric-ttml-internal" itunes:timing="Word">
//
//    <head>
//        <metadata>
//            <ttm:agent type="person" xml:id="v1" />
//            <ttm:agent type="other" xml:id="v2" />
//        </metadata>
//    </head>
//
//    <body dur="03:09.810">
//        <div begin="00:01.019" end="03:09.810">
//            <p begin="00:01.019" end="00:02.089" ttm:agent="v1" itunes:key="L1"><span begin="00:01.019"
//                    end="00:02.089">Day</span></p>
//            <p begin="00:02.089" end="00:03.448" ttm:agent="v1" itunes:key="L2"><span begin="00:02.089"
//                    end="00:02.892">25/</span><span begin="00:02.892" end="00:03.448">8</span></p>
//            <p begin="00:03.639" end="00:05.581" ttm:agent="v1" itunes:key="L3"><span begin="00:03.639"
//                    end="00:04.146">Ah-</span><span begin="00:04.146" end="00:04.547">ah,</span> <span begin="00:04.719"
//                    end="00:05.258">ah-</span><span begin="00:05.258" end="00:05.581">ah</span></p>
//            <p begin="00:05.695" end="00:07.755" ttm:agent="v1" itunes:key="L4"><span begin="00:05.695"
//                    end="00:06.000">Can</span> <span begin="00:06.000" end="00:06.148">you</span> <span
//                    begin="00:06.148" end="00:06.373">keep</span> <span begin="00:06.373" end="00:06.744">up,</span>
//                <span begin="00:06.744" end="00:07.012">keep</span> <span begin="00:07.012" end="00:07.291">it</span>
//                <span begin="00:07.291" end="00:07.755">up?</span></p>
//            <p begin="00:07.755" end="00:09.703" ttm:agent="v1" itunes:key="L5"><span begin="00:07.755"
//                    end="00:08.036">Keep</span> <span begin="00:08.036" end="00:08.187">it</span> <span
//                    begin="00:08.187" end="00:08.434">up</span> <span begin="00:08.434" end="00:08.812">all</span> <span
//                    begin="00:08.812" end="00:09.043">night</span> <span begin="00:09.043" end="00:09.307">and</span>
//                <span begin="00:09.307" end="00:09.703">day</span></p>
//            <p begin="00:09.703" end="00:11.368" ttm:agent="v1" itunes:key="L6"><span begin="00:09.703"
//                    end="00:10.864">25/</span><span begin="00:10.864" end="00:11.368">8</span></p>
//            <p begin="00:11.917" end="00:13.875" ttm:agent="v1" itunes:key="L7"><span begin="00:11.917"
//                    end="00:12.428">Ah-</span><span begin="00:12.428" end="00:12.809">ah,</span> <span begin="00:12.980"
//                    end="00:13.517">ah-</span><span begin="00:13.517" end="00:13.875">ah</span></p>
//            <p begin="00:13.983" end="00:16.031" ttm:agent="v1" itunes:key="L8"><span begin="00:13.983"
//                    end="00:14.275">Can</span> <span begin="00:14.275" end="00:14.428">you</span> <span
//                    begin="00:14.428" end="00:14.659">keep</span> <span begin="00:14.659" end="00:14.988">up,</span>
//                <span begin="00:14.988" end="00:15.239">keep</span> <span begin="00:15.239" end="00:15.531">it</span>
//                <span begin="00:15.531" end="00:16.031">up?</span></p>
//            <p begin="00:16.031" end="00:17.974" ttm:agent="v1" itunes:key="L9"><span begin="00:16.031"
//                    end="00:16.248">Speed</span> <span begin="00:16.248" end="00:16.435">it</span> <span
//                    begin="00:16.435" end="00:16.687">up</span> <span begin="00:16.687" end="00:16.978">like</span>
//                <span begin="00:16.978" end="00:17.263">a</span> <span begin="00:17.263" end="00:17.974">rocket</span>
//            </p>
//            <p begin="00:17.974" end="00:19.711" ttm:agent="v1" itunes:key="L10"><span begin="00:17.974"
//                    end="00:19.144">25/</span><span begin="00:19.144" end="00:19.711">8</span></p>
//            <p begin="00:20.196" end="00:22.252" ttm:agent="v1" itunes:key="L11"><span begin="00:20.196"
//                    end="00:20.479">너</span><span begin="00:20.479" end="00:20.648">를</span> <span begin="00:20.648"
//                    end="00:20.877">가</span><span begin="00:20.877" end="00:21.008">리</span><span begin="00:21.008"
//                    end="00:21.127">키</span><span begin="00:21.127" end="00:21.258">는</span> <span begin="00:21.258"
//                    end="00:22.252">GPS</span></p>
//            <p begin="00:22.252" end="00:24.354" ttm:agent="v1" itunes:key="L12"><span begin="00:22.252"
//                    end="00:22.657">Baby,</span> <span begin="00:22.657" end="00:23.037">faster</span> <span
//                    begin="00:23.037" end="00:23.197">than</span> <span begin="00:23.197" end="00:23.328">a</span> <span
//                    begin="00:23.328" end="00:23.859">private</span> <span begin="00:23.859" end="00:24.354">jet</span>
//            </p>
//            <p begin="00:24.354" end="00:26.298" ttm:agent="v1" itunes:key="L13"><span begin="00:24.354"
//                    end="00:24.629">떠</span><span begin="00:24.629" end="00:24.764">날</span><span begin="00:24.764"
//                    end="00:24.966">게</span> <span begin="00:24.966" end="00:25.227">Seoul</span> <span
//                    begin="00:25.227" end="00:25.380">to</span> <span begin="00:25.380" end="00:26.298">LAX</span></p>
//            <p begin="00:26.659" end="00:27.972" ttm:agent="v1" itunes:key="L14"><span begin="00:26.659"
//                    end="00:26.915">Ah-</span><span begin="00:26.915" end="00:27.157">ah-</span><span begin="00:27.157"
//                    end="00:27.427">ah,</span> <span begin="00:27.427" end="00:27.684">ah-</span><span begin="00:27.684"
//                    end="00:27.972">ah</span></p>
//            <p begin="00:28.463" end="00:30.514" ttm:agent="v1" itunes:key="L15"><span begin="00:28.463"
//                    end="00:28.845">Baby</span> <span begin="00:28.845" end="00:29.121">구</span><span begin="00:29.121"
//                    end="00:29.272">름</span> <span begin="00:29.272" end="00:29.407">위</span><span begin="00:29.407"
//                    end="00:29.539">로</span> <span begin="00:29.539" end="00:29.790">날</span><span begin="00:29.790"
//                    end="00:30.046">아</span><span begin="00:30.046" end="00:30.514">서</span></p>
//            <p begin="00:30.514" end="00:32.603" ttm:agent="v1" itunes:key="L16"><span begin="00:30.514"
//                    end="00:30.834">Take</span> <span begin="00:30.834" end="00:30.978">me</span> <span
//                    begin="00:30.978" end="00:31.347">higher</span> <span begin="00:31.347" end="00:31.473">than</span>
//                <span begin="00:31.473" end="00:32.603">electrolytes</span></p>
//            <p begin="00:32.603" end="00:34.663" ttm:agent="v1" itunes:key="L17"><span begin="00:32.603"
//                    end="00:32.901">내</span> <span begin="00:32.901" end="00:33.048">심</span><span begin="00:33.048"
//                    end="00:33.277">장</span><span begin="00:33.277" end="00:33.412">은</span> <span begin="00:33.412"
//                    end="00:33.539">지</span><span begin="00:33.539" end="00:33.682">금</span> <span begin="00:33.682"
//                    end="00:34.663">Overdrive</span></p>
//            <p begin="00:34.929" end="00:36.270" ttm:agent="v1" itunes:key="L18"><span begin="00:34.929"
//                    end="00:35.195">Ah-</span><span begin="00:35.195" end="00:35.451">ah-</span><span begin="00:35.451"
//                    end="00:35.721">ah,</span> <span begin="00:35.721" end="00:36.000">ah-</span><span begin="00:36.000"
//                    end="00:36.270">ah</span></p>
//            <p begin="00:36.270" end="00:38.808" ttm:agent="v1" itunes:key="L19"><span begin="00:36.270"
//                    end="00:36.756">Stop</span> <span begin="00:36.756" end="00:37.012">지</span><span begin="00:37.012"
//                    end="00:37.174">체</span><span begin="00:37.174" end="00:37.395">할</span> <span begin="00:37.395"
//                    end="00:37.523">시</span><span begin="00:37.523" end="00:37.674">간</span> <span begin="00:37.674"
//                    end="00:37.791">따</span><span begin="00:37.791" end="00:38.038">윈</span> <span begin="00:38.038"
//                    end="00:38.304">없</span><span begin="00:38.304" end="00:38.808">어</span></p>
//            <p begin="00:38.808" end="00:40.860" ttm:agent="v1" itunes:key="L20"><span begin="00:38.808"
//                    end="00:39.064">I'm</span> <span begin="00:39.064" end="00:39.231">your</span> <span
//                    begin="00:39.231" end="00:39.433">wave</span> <span begin="00:39.433" end="00:39.586">너</span><span
//                    begin="00:39.586" end="00:39.712">에</span><span begin="00:39.712" end="00:39.856">게</span> <span
//                    begin="00:39.856" end="00:40.081">번</span><span begin="00:40.081" end="00:40.387">져</span><span
//                    begin="00:40.387" end="00:40.860">가</span></p>
//            <p begin="00:40.860" end="00:42.462" ttm:agent="v1" itunes:key="L21"><span begin="00:40.860"
//                    end="00:41.098">끝</span><span begin="00:41.098" end="00:41.251">없</span><span begin="00:41.251"
//                    end="00:41.481">는</span> <span begin="00:41.481" end="00:41.616">우</span><span begin="00:41.616"
//                    end="00:41.769">리</span><span begin="00:41.769" end="00:41.918">의</span> <span begin="00:41.918"
//                    end="00:42.138">시</span><span begin="00:42.138" end="00:42.462">간</span></p>
//            <p begin="00:42.462" end="00:44.527" ttm:agent="v1" itunes:key="L22"><span begin="00:42.462"
//                    end="00:42.682">On</span> <span begin="00:42.682" end="00:42.840">and</span> <span begin="00:42.840"
//                    end="00:43.056">on</span> <span begin="00:43.056" end="00:43.200">and</span> <span begin="00:43.200"
//                    end="00:43.411">on</span> <span begin="00:43.411" end="00:43.560">and</span> <span begin="00:43.560"
//                    end="00:43.794">on</span> <span begin="00:43.794" end="00:43.969">and</span> <span begin="00:43.969"
//                    end="00:44.244">on</span> <span begin="00:44.244" end="00:44.527">and</span></p>
//            <p begin="00:45.018" end="00:47.133" ttm:agent="v1" itunes:key="L23"><span begin="00:45.018"
//                    end="00:45.503">Ah-</span><span begin="00:45.503" end="00:45.934">ah,</span> <span begin="00:46.071"
//                    end="00:46.629">ah-</span><span begin="00:46.629" end="00:47.133">ah</span></p>
//            <p begin="00:47.133" end="00:49.153" ttm:agent="v1" itunes:key="L24"><span begin="00:47.133"
//                    end="00:47.407">Can</span> <span begin="00:47.407" end="00:47.560">you</span> <span
//                    begin="00:47.560" end="00:47.759">keep</span> <span begin="00:47.759" end="00:48.154">up,</span>
//                <span begin="00:48.154" end="00:48.420">keep</span> <span begin="00:48.420" end="00:48.673">it</span>
//                <span begin="00:48.673" end="00:49.153">up?</span></p>
//            <p begin="00:49.153" end="00:51.088" ttm:agent="v1" itunes:key="L25"><span begin="00:49.153"
//                    end="00:49.414">Keep</span> <span begin="00:49.414" end="00:49.573">it</span> <span
//                    begin="00:49.573" end="00:49.792">up</span> <span begin="00:49.792" end="00:50.220">all</span> <span
//                    begin="00:50.220" end="00:50.459">night</span> <span begin="00:50.459" end="00:50.755">and</span>
//                <span begin="00:50.755" end="00:51.088">day</span></p>
//            <p begin="00:51.088" end="00:52.798" ttm:agent="v1" itunes:key="L26"><span begin="00:51.088"
//                    end="00:52.222">25/</span><span begin="00:52.222" end="00:52.798">8</span></p>
//            <p begin="00:53.343" end="00:55.431" ttm:agent="v1" itunes:key="L27"><span begin="00:53.343"
//                    end="00:53.824">Ah-</span><span begin="00:53.824" end="00:54.135">ah,</span> <span begin="00:54.400"
//                    end="00:54.963">ah-</span><span begin="00:54.963" end="00:55.431">ah</span></p>
//            <p begin="00:55.431" end="00:57.442" ttm:agent="v1" itunes:key="L28"><span begin="00:55.431"
//                    end="00:55.698">Can</span> <span begin="00:55.698" end="00:55.849">you</span> <span
//                    begin="00:55.849" end="00:56.070">keep</span> <span begin="00:56.070" end="00:56.417">up,</span>
//                <span begin="00:56.417" end="00:56.638">keep</span> <span begin="00:56.638" end="00:56.929">it</span>
//                <span begin="00:56.929" end="00:57.442">up?</span></p>
//            <p begin="00:57.442" end="00:59.364" ttm:agent="v1" itunes:key="L29"><span begin="00:57.442"
//                    end="00:57.681">Speed</span> <span begin="00:57.681" end="00:57.856">it</span> <span
//                    begin="00:57.856" end="00:58.072">up</span> <span begin="00:58.072" end="00:58.437">like</span>
//                <span begin="00:58.437" end="00:58.693">a</span> <span begin="00:58.693" end="00:59.364">rocket</span>
//            </p>
//            <p begin="00:59.364" end="01:01.020" ttm:agent="v1" itunes:key="L30"><span begin="00:59.364"
//                    end="01:00.538">25/</span><span begin="01:00.538" end="01:01.020">8</span></p>
//            <p begin="01:01.573" end="01:03.630" ttm:agent="v1" itunes:key="L31"><span begin="01:01.573"
//                    end="01:01.848">내</span> <span begin="01:01.848" end="01:02.010">눈</span><span begin="01:02.010"
//                    end="01:02.239">빛</span><span begin="01:02.239" end="01:02.383">이</span> <span begin="01:02.383"
//                    end="01:02.514">전</span><span begin="01:02.514" end="01:02.644">해</span><span begin="01:02.644"
//                    end="01:02.892">진</span> <span begin="01:02.892" end="01:03.184">순</span><span begin="01:03.184"
//                    end="01:03.630">간</span></p>
//            <p begin="01:03.630" end="01:05.655" ttm:agent="v1" itunes:key="L32"><span begin="01:03.630"
//                    end="01:03.897">네</span> <span begin="01:03.897" end="01:04.053">떨</span><span begin="01:04.053"
//                    end="01:04.273">림</span><span begin="01:04.273" end="01:04.422">이</span> <span begin="01:04.422"
//                    end="01:04.548">더</span><span begin="01:04.548" end="01:04.687">해</span><span begin="01:04.687"
//                    end="01:04.939">진</span> <span begin="01:04.939" end="01:05.218">순</span><span begin="01:05.218"
//                    end="01:05.655">간</span></p>
//            <p begin="01:05.655" end="01:08.323" ttm:agent="v1" itunes:key="L33"><span begin="01:05.655"
//                    end="01:05.916">Put</span> <span begin="01:05.916" end="01:06.078">your</span> <span
//                    begin="01:06.078" end="01:06.483">loving</span> <span begin="01:06.483" end="01:06.627">on</span>
//                <span begin="01:06.627" end="01:06.786">me</span> <span begin="01:06.786" end="01:07.018">night</span>
//                <span begin="01:07.018" end="01:07.235">and</span> <span begin="01:07.235" end="01:08.323">day</span>
//            </p>
//            <p begin="01:08.323" end="01:09.831" ttm:agent="v1" itunes:key="L34"><span begin="01:08.323"
//                    end="01:09.080">25/</span><span begin="01:09.080" end="01:09.831">8</span></p>
//            <p begin="01:09.831" end="01:11.919" ttm:agent="v1" itunes:key="L35"><span begin="01:09.831"
//                    end="01:10.123">내</span> <span begin="01:10.123" end="01:10.285">불</span><span begin="01:10.285"
//                    end="01:10.515">꽃</span><span begin="01:10.515" end="01:10.636">이</span> <span begin="01:10.636"
//                    end="01:10.780">널</span> <span begin="01:10.780" end="01:10.911">태</span><span begin="01:10.911"
//                    end="01:11.127">우</span><span begin="01:11.127" end="01:11.419">듯</span><span begin="01:11.419"
//                    end="01:11.919">이</span></p>
//            <p begin="01:11.919" end="01:13.971" ttm:agent="v1" itunes:key="L36"><span begin="01:11.919"
//                    end="01:12.168">내</span> <span begin="01:12.168" end="01:12.328">숨</span><span begin="01:12.328"
//                    end="01:12.553">결</span><span begin="01:12.553" end="01:12.679">이</span> <span begin="01:12.679"
//                    end="01:12.806">널</span> <span begin="01:12.806" end="01:12.958">깨</span><span begin="01:12.958"
//                    end="01:13.197">우</span><span begin="01:13.197" end="01:13.467">듯</span><span begin="01:13.467"
//                    end="01:13.971">이</span></p>
//            <p begin="01:13.971" end="01:16.050" ttm:agent="v1" itunes:key="L37"><span begin="01:13.971"
//                    end="01:14.227">Put</span> <span begin="01:14.227" end="01:14.407">your</span> <span
//                    begin="01:14.407" end="01:14.778">loving</span> <span begin="01:14.778" end="01:14.934">on</span>
//                <span begin="01:14.934" end="01:15.073">me</span> <span begin="01:15.073" end="01:15.303">night</span>
//                <span begin="01:15.303" end="01:15.552">and</span> <span begin="01:15.552" end="01:16.050">day</span>
//            </p>
//            <p begin="01:15.895" end="01:17.616" ttm:agent="v1" itunes:key="L38"><span begin="01:15.895"
//                    end="01:17.096">25/</span><span begin="01:17.096" end="01:17.616">8</span></p>
//            <p begin="01:18.174" end="01:20.206" ttm:agent="v1" itunes:key="L39"><span begin="01:18.174"
//                    end="01:18.406">Want</span> <span begin="01:18.406" end="01:18.563">you</span> <span
//                    begin="01:18.563" end="01:18.784">more</span> <span begin="01:18.784" end="01:18.937">than</span>
//                <span begin="01:18.937" end="01:19.213">every</span> <span begin="01:19.213"
//                    end="01:19.713">single</span> <span begin="01:19.713" end="01:20.206">day</span></p>
//            <p begin="01:20.206" end="01:22.186" ttm:agent="v1" itunes:key="L40"><span begin="01:20.206"
//                    end="01:20.482">Keep</span> <span begin="01:20.482" end="01:20.620">it</span> <span
//                    begin="01:20.620" end="01:21.007">private</span> <span begin="01:21.007" end="01:21.164">like</span>
//                <span begin="01:21.164" end="01:21.308">an</span> <span begin="01:21.308" end="01:22.186">NDA</span></p>
//            <p begin="01:22.186" end="01:24.329" ttm:agent="v1" itunes:key="L41"><span begin="01:22.186"
//                    end="01:22.560">내</span><span begin="01:22.560" end="01:22.717">가</span> <span begin="01:22.717"
//                    end="01:22.951">열</span><span begin="01:22.951" end="01:23.083">어</span> <span begin="01:23.083"
//                    end="01:23.203">줄</span><span begin="01:23.203" end="01:23.348">게</span> <span begin="01:23.348"
//                    end="01:23.932">Heaven's</span> <span begin="01:23.932" end="01:24.329">gate</span></p>
//            <p begin="01:24.622" end="01:25.921" ttm:agent="v1" itunes:key="L42"><span begin="01:24.622"
//                    end="01:24.886">Ah-</span><span begin="01:24.886" end="01:25.142">ah-</span><span begin="01:25.142"
//                    end="01:25.394">ah,</span> <span begin="01:25.394" end="01:25.655">ah-</span><span begin="01:25.655"
//                    end="01:25.921">ah</span></p>
//            <p begin="01:26.386" end="01:28.464" ttm:agent="v1" itunes:key="L43"><span begin="01:26.386"
//                    end="01:26.678">너</span><span begin="01:26.678" end="01:26.843">라</span><span begin="01:26.843"
//                    end="01:27.055">는</span> <span begin="01:27.055" end="01:27.212">흐</span><span begin="01:27.212"
//                    end="01:27.352">름</span><span begin="01:27.352" end="01:27.496">에</span> <span begin="01:27.496"
//                    end="01:27.739">Ride</span> <span begin="01:27.739" end="01:28.005">or</span> <span
//                    begin="01:28.005" end="01:28.464">die</span></p>
//            <p begin="01:28.464" end="01:30.511" ttm:agent="v1" itunes:key="L44"><span begin="01:28.464"
//                    end="01:28.900">Every</span> <span begin="01:28.900" end="01:29.287">second</span> <span
//                    begin="01:29.287" end="01:29.431">will</span> <span begin="01:29.431" end="01:29.566">be</span>
//                <span begin="01:29.566" end="01:30.511">beautiful</span></p>
//            <p begin="01:30.511" end="01:32.469" ttm:agent="v1" itunes:key="L45"><span begin="01:30.511"
//                    end="01:30.848">My</span> <span begin="01:30.848" end="01:31.006">heart</span> <span
//                    begin="01:31.006" end="01:31.222">is</span> <span begin="01:31.222" end="01:31.339">so</span> <span
//                    begin="01:31.339" end="01:32.469">unusual</span></p>
//            <p begin="01:32.873" end="01:34.192" ttm:agent="v1" itunes:key="L46"><span begin="01:32.873"
//                    end="01:33.143">Ah-</span><span begin="01:33.143" end="01:33.395">ah-</span><span begin="01:33.395"
//                    end="01:33.647">ah,</span> <span begin="01:33.647" end="01:33.895">ah-</span><span begin="01:33.895"
//                    end="01:34.192">ah</span></p>
//            <p begin="01:34.192" end="01:36.752" ttm:agent="v1" itunes:key="L47"><span begin="01:34.192"
//                    end="01:34.651">Stop</span> <span begin="01:34.651" end="01:34.930">망</span><span begin="01:34.930"
//                    end="01:35.105">설</span><span begin="01:35.105" end="01:35.340">일</span> <span begin="01:35.340"
//                    end="01:35.474">여</span><span begin="01:35.474" end="01:35.618">유</span><span begin="01:35.618"
//                    end="01:35.753">는</span> <span begin="01:35.753" end="01:35.983">더</span> <span begin="01:35.983"
//                    end="01:36.240">없</span><span begin="01:36.240" end="01:36.752">어</span></p>
//            <p begin="01:36.752" end="01:38.791" ttm:agent="v1" itunes:key="L48"><span begin="01:36.752"
//                    end="01:37.004">I'm</span> <span begin="01:37.004" end="01:37.166">your</span> <span
//                    begin="01:37.166" end="01:37.396">flame</span> <span begin="01:37.396" end="01:37.546">어</span><span
//                    begin="01:37.546" end="01:37.675">둠</span><span begin="01:37.675" end="01:37.810">을</span> <span
//                    begin="01:37.810" end="01:38.057">태</span><span begin="01:38.057" end="01:38.309">워</span><span
//                    begin="01:38.309" end="01:38.791">가</span></p>
//            <p begin="01:38.791" end="01:40.379" ttm:agent="v1" itunes:key="L49"><span begin="01:38.791"
//                    end="01:39.067">끝</span><span begin="01:39.067" end="01:39.232">없</span><span begin="01:39.232"
//                    end="01:39.439">는</span> <span begin="01:39.439" end="01:39.569">우</span><span begin="01:39.569"
//                    end="01:39.691">리</span><span begin="01:39.691" end="01:39.862">의</span> <span begin="01:39.862"
//                    end="01:40.096">시</span><span begin="01:40.096" end="01:40.379">간</span></p>
//            <p begin="01:40.379" end="01:42.490" ttm:agent="v1" itunes:key="L50"><span begin="01:40.379"
//                    end="01:40.613">On</span> <span begin="01:40.613" end="01:40.780">and</span> <span begin="01:40.780"
//                    end="01:41.018">on</span> <span begin="01:41.018" end="01:41.167">and</span> <span begin="01:41.167"
//                    end="01:41.387">on</span> <span begin="01:41.387" end="01:41.545">and</span> <span begin="01:41.545"
//                    end="01:41.770">on</span> <span begin="01:41.770" end="01:41.932">and</span> <span begin="01:41.932"
//                    end="01:42.202">on</span> <span begin="01:42.202" end="01:42.490">and</span></p>
//            <p begin="01:42.960" end="01:45.044" ttm:agent="v1" itunes:key="L51"><span begin="01:42.960"
//                    end="01:43.484">Ah-</span><span begin="01:43.484" end="01:43.834">ah,</span> <span begin="01:44.024"
//                    end="01:44.562">ah-</span><span begin="01:44.562" end="01:45.044">ah</span></p>
//            <p begin="01:45.044" end="01:47.143" ttm:agent="v1" itunes:key="L52"><span begin="01:45.044"
//                    end="01:45.311">Can</span> <span begin="01:45.311" end="01:45.451">you</span> <span
//                    begin="01:45.451" end="01:45.689">keep</span> <span begin="01:45.689" end="01:46.090">up,</span>
//                <span begin="01:46.090" end="01:46.342">keep</span> <span begin="01:46.342" end="01:46.589">it</span>
//                <span begin="01:46.589" end="01:47.143">up?</span></p>
//            <p begin="01:47.143" end="01:49.033" ttm:agent="v1" itunes:key="L53"><span begin="01:47.143"
//                    end="01:47.377">Keep</span> <span begin="01:47.377" end="01:47.550">it</span> <span
//                    begin="01:47.550" end="01:47.768">up</span> <span begin="01:47.768" end="01:48.142">all</span> <span
//                    begin="01:48.142" end="01:48.434">night</span> <span begin="01:48.434" end="01:48.682">and</span>
//                <span begin="01:48.682" end="01:49.033">day</span></p>
//            <p begin="01:49.033" end="01:50.542" ttm:agent="v1" itunes:key="L54"><span begin="01:49.033"
//                    end="01:50.216">25/</span><span begin="01:50.216" end="01:50.542">8</span></p>
//            <p begin="01:51.217" end="01:53.281" ttm:agent="v1" itunes:key="L55"><span begin="01:51.217"
//                    end="01:51.737">Ah-</span><span begin="01:51.737" end="01:52.043">ah,</span> <span begin="01:52.310"
//                    end="01:52.822">ah-</span><span begin="01:52.822" end="01:53.281">ah</span></p>
//            <p begin="01:53.281" end="01:55.351" ttm:agent="v1" itunes:key="L56"><span begin="01:53.281"
//                    end="01:53.565">Can</span> <span begin="01:53.565" end="01:53.740">you</span> <span
//                    begin="01:53.740" end="01:53.960">keep</span> <span begin="01:53.960" end="01:54.316">up,</span>
//                <span begin="01:54.316" end="01:54.586">keep</span> <span begin="01:54.586" end="01:54.862">it</span>
//                <span begin="01:54.862" end="01:55.351">up?</span></p>
//            <p begin="01:55.351" end="01:57.277" ttm:agent="v1" itunes:key="L57"><span begin="01:55.351"
//                    end="01:55.643">Speed</span> <span begin="01:55.643" end="01:55.801">it</span> <span
//                    begin="01:55.801" end="01:56.035">up</span> <span begin="01:56.035" end="01:56.377">like</span>
//                <span begin="01:56.377" end="01:56.656">a</span> <span begin="01:56.656" end="01:57.277">rocket</span>
//            </p>
//            <p begin="01:57.277" end="01:58.982" ttm:agent="v1" itunes:key="L58"><span begin="01:57.277"
//                    end="01:58.502">25/</span><span begin="01:58.502" end="01:58.982">8</span></p>
//            <p begin="01:59.528" end="02:01.564" ttm:agent="v1" itunes:key="L59"><span begin="01:59.528"
//                    end="01:59.780">내</span> <span begin="01:59.780" end="01:59.960">눈</span><span begin="01:59.960"
//                    end="02:00.188">빛</span><span begin="02:00.188" end="02:00.337">이</span> <span begin="02:00.337"
//                    end="02:00.449">전</span><span begin="02:00.449" end="02:00.584">해</span><span begin="02:00.584"
//                    end="02:00.836">진</span> <span begin="02:00.836" end="02:01.124">순</span><span begin="02:01.124"
//                    end="02:01.564">간</span></p>
//            <p begin="02:01.564" end="02:03.629" ttm:agent="v1" itunes:key="L60"><span begin="02:01.564"
//                    end="02:01.867">네</span> <span begin="02:01.867" end="02:02.020">떨</span><span begin="02:02.020"
//                    end="02:02.242">림</span><span begin="02:02.242" end="02:02.362">이</span> <span begin="02:02.362"
//                    end="02:02.483">더</span><span begin="02:02.483" end="02:02.632">해</span><span begin="02:02.632"
//                    end="02:02.886">진</span> <span begin="02:02.886" end="02:03.176">순</span><span begin="02:03.176"
//                    end="02:03.629">간</span></p>
//            <p begin="02:03.629" end="02:06.286" ttm:agent="v1" itunes:key="L61"><span begin="02:03.629"
//                    end="02:03.919">Put</span> <span begin="02:03.919" end="02:04.087">your</span> <span
//                    begin="02:04.087" end="02:04.418">loving</span> <span begin="02:04.418" end="02:04.586">on</span>
//                <span begin="02:04.586" end="02:04.733">me</span> <span begin="02:04.733" end="02:04.972">night</span>
//                <span begin="02:04.972" end="02:05.215">and</span> <span begin="02:05.215" end="02:06.286">day</span>
//            </p>
//            <p begin="02:06.286" end="02:07.546" ttm:agent="v1" itunes:key="L62"><span begin="02:06.286"
//                    end="02:07.006">25/</span><span begin="02:07.006" end="02:07.546">8</span></p>
//            <p begin="02:07.807" end="02:09.845" ttm:agent="v1" itunes:key="L63"><span begin="02:07.807"
//                    end="02:08.063">내</span> <span begin="02:08.063" end="02:08.230">불</span><span begin="02:08.230"
//                    end="02:08.437">꽃</span><span begin="02:08.437" end="02:08.567">이</span> <span begin="02:08.567"
//                    end="02:08.702">널</span> <span begin="02:08.702" end="02:08.851">태</span><span begin="02:08.851"
//                    end="02:09.076">우</span><span begin="02:09.076" end="02:09.360">듯</span><span begin="02:09.360"
//                    end="02:09.845">이</span></p>
//            <p begin="02:09.845" end="02:11.938" ttm:agent="v1" itunes:key="L64"><span begin="02:09.845"
//                    end="02:10.120">내</span> <span begin="02:10.120" end="02:10.300">숨</span><span begin="02:10.300"
//                    end="02:10.502">결</span><span begin="02:10.502" end="02:10.642">이</span> <span begin="02:10.642"
//                    end="02:10.786">널</span> <span begin="02:10.786" end="02:10.918">깨</span><span begin="02:10.918"
//                    end="02:11.168">우</span><span begin="02:11.168" end="02:11.429">듯</span><span begin="02:11.429"
//                    end="02:11.938">이</span></p>
//            <p begin="02:11.938" end="02:13.837" ttm:agent="v1" itunes:key="L65"><span begin="02:11.938"
//                    end="02:12.203">Put</span> <span begin="02:12.203" end="02:12.392">your</span> <span
//                    begin="02:12.392" end="02:12.707">loving</span> <span begin="02:12.707" end="02:12.869">on</span>
//                <span begin="02:12.869" end="02:12.991">me</span> <span begin="02:12.991" end="02:13.229">night</span>
//                <span begin="02:13.229" end="02:13.495">and</span> <span begin="02:13.495" end="02:13.837">day</span>
//            </p>
//            <p begin="02:13.837" end="02:15.568" ttm:agent="v1" itunes:key="L66"><span begin="02:13.837"
//                    end="02:15.009">25/</span><span begin="02:15.009" end="02:15.568">8</span></p>
//            <p begin="02:15.568" end="02:16.577" ttm:agent="v1" itunes:key="L67"><span begin="02:15.568"
//                    end="02:16.126">Wow,</span> <span begin="02:16.126" end="02:16.420">we</span> <span
//                    begin="02:16.420" end="02:16.577">fly</span></p>
//            <p begin="02:16.577" end="02:20.079" ttm:agent="v1" itunes:key="L68"><span begin="02:16.577"
//                    end="02:16.936">Baby,</span> <span begin="02:16.936" end="02:17.218">we</span> <span
//                    begin="02:17.218" end="02:17.470">don't</span> <span begin="02:17.470" end="02:17.728">slow</span>
//                <span begin="02:17.728" end="02:18.238">down</span></p>
//            <p begin="02:20.079" end="02:21.027" ttm:agent="v1" itunes:key="L69"><span begin="02:20.079"
//                    end="02:20.506">Still</span> <span begin="02:20.506" end="02:20.680">we</span> <span
//                    begin="02:20.680" end="02:21.027">high</span></p>
//            <p begin="02:21.027" end="02:24.258" ttm:agent="v1" itunes:key="L70"><span begin="02:21.027"
//                    end="02:21.358">You</span> <span begin="02:21.358" end="02:21.604">can't</span> <span
//                    begin="02:21.604" end="02:21.880">stop</span> <span begin="02:21.880" end="02:22.396">now</span></p>
//            <p begin="02:24.258" end="02:26.706" ttm:agent="v1" itunes:key="L71"><span begin="02:24.258"
//                    end="02:24.606">시</span><span begin="02:24.606" end="02:24.798">간</span><span begin="02:24.798"
//                    end="02:25.032">조</span><span begin="02:25.032" end="02:25.163">차</span> <span begin="02:25.163"
//                    end="02:25.290">멈</span><span begin="02:25.290" end="02:25.442">춘</span> <span begin="02:25.442"
//                    end="02:25.654">이</span> <span begin="02:25.654" end="02:25.906">순</span><span begin="02:25.906"
//                    end="02:26.706">간</span></p>
//            <p begin="02:27.403" end="02:30.063" ttm:agent="v1" itunes:key="L72"><span begin="02:27.403"
//                    end="02:27.998">Oh,</span> <span begin="02:27.998" end="02:28.238">on</span> <span begin="02:28.238"
//                    end="02:28.394">and</span> <span begin="02:28.394" end="02:28.630">on</span> <span begin="02:28.630"
//                    end="02:28.784">and</span> <span begin="02:28.784" end="02:28.990">on</span> <span begin="02:28.990"
//                    end="02:29.150">and</span> <span begin="02:29.150" end="02:29.378">on</span> <span begin="02:29.378"
//                    end="02:29.550">and</span> <span begin="02:29.550" end="02:29.816">on</span> <span begin="02:29.816"
//                    end="02:30.063">and</span></p>
//            <p begin="02:30.063" end="02:32.106" ttm:agent="v1" itunes:key="L73"><span begin="02:30.063"
//                    end="02:30.298">On</span> <span begin="02:30.298" end="02:30.452">and</span> <span begin="02:30.452"
//                    end="02:30.691">on</span> <span begin="02:30.691" end="02:30.838">and</span> <span begin="02:30.838"
//                    end="02:31.070">on</span> <span begin="02:31.070" end="02:31.218">and</span> <span begin="02:31.218"
//                    end="02:31.438">on</span> <span begin="02:31.438" end="02:31.598">and</span> <span begin="02:31.598"
//                    end="02:31.842">on</span> <span begin="02:31.842" end="02:32.106">and</span></p>
//            <p begin="02:32.106" end="02:34.158" ttm:agent="v1" itunes:key="L74"><span begin="02:32.106"
//                    end="02:32.350">On</span> <span begin="02:32.350" end="02:32.498">and</span> <span begin="02:32.498"
//                    end="02:32.750">on</span> <span begin="02:32.750" end="02:32.898">and</span> <span begin="02:32.898"
//                    end="02:33.090">on</span> <span begin="02:33.090" end="02:33.246">and</span> <span begin="02:33.246"
//                    end="02:33.506">on</span> <span begin="02:33.506" end="02:33.670">and</span> <span begin="02:33.670"
//                    end="02:33.946">on</span> <span begin="02:33.946" end="02:34.158">and</span></p>
//            <p begin="02:34.675" end="02:36.758" ttm:agent="v1" itunes:key="L75"><span begin="02:34.675"
//                    end="02:35.174">Ah-</span><span begin="02:35.174" end="02:35.450">ah,</span> <span begin="02:35.708"
//                    end="02:36.270">ah-</span><span begin="02:36.270" end="02:36.758">ah</span></p>
//            <p begin="02:36.758" end="02:38.786" ttm:agent="v1" itunes:key="L76"><span begin="02:36.758"
//                    end="02:37.038">Can</span> <span begin="02:37.038" end="02:37.178">you</span> <span
//                    begin="02:37.178" end="02:37.395">keep</span> <span begin="02:37.395" end="02:37.818">up,</span>
//                <span begin="02:37.818" end="02:38.066">keep</span> <span begin="02:38.066" end="02:38.306">it</span>
//                <span begin="02:38.306" end="02:38.786">up?</span></p>
//            <p begin="02:38.786" end="02:40.702" ttm:agent="v1" itunes:key="L77"><span begin="02:38.786"
//                    end="02:39.078">Keep</span> <span begin="02:39.078" end="02:39.230">it</span> <span
//                    begin="02:39.230" end="02:39.444">up</span> <span begin="02:39.444" end="02:39.850">all</span> <span
//                    begin="02:39.850" end="02:40.090">night</span> <span begin="02:40.090" end="02:40.418">and</span>
//                <span begin="02:40.418" end="02:40.702">day</span></p>
//            <p begin="02:40.702" end="02:42.442" ttm:agent="v1" itunes:key="L78"><span begin="02:40.702"
//                    end="02:41.918">25/</span><span begin="02:41.918" end="02:42.442">8</span></p>
//            <p begin="02:43.030" end="02:45.038" ttm:agent="v1" itunes:key="L79"><span begin="02:43.030"
//                    end="02:43.482">Ah-</span><span begin="02:43.482" end="02:43.810">ah,</span> <span begin="02:44.018"
//                    end="02:44.546">ah-</span><span begin="02:44.546" end="02:45.038">ah</span></p>
//            <p begin="02:45.038" end="02:47.058" ttm:agent="v1" itunes:key="L80"><span begin="02:45.038"
//                    end="02:45.302">Can</span> <span begin="02:45.302" end="02:45.443">you</span> <span
//                    begin="02:45.443" end="02:45.664">keep</span> <span begin="02:45.664" end="02:46.043">up,</span>
//                <span begin="02:46.043" end="02:46.306">keep</span> <span begin="02:46.306" end="02:46.570">it</span>
//                <span begin="02:46.570" end="02:47.058">up?</span></p>
//            <p begin="02:47.058" end="02:49.002" ttm:agent="v1" itunes:key="L81"><span begin="02:47.058"
//                    end="02:47.330">Speed</span> <span begin="02:47.330" end="02:47.510">it</span> <span
//                    begin="02:47.510" end="02:47.722">up</span> <span begin="02:47.722" end="02:48.102">like</span>
//                <span begin="02:48.102" end="02:48.376">a</span> <span begin="02:48.376" end="02:49.002">rocket</span>
//            </p>
//            <p begin="02:49.002" end="02:50.711" ttm:agent="v1" itunes:key="L82"><span begin="02:49.002"
//                    end="02:50.182">25/</span><span begin="02:50.182" end="02:50.711">8</span></p>
//            <p begin="02:51.252" end="02:53.310" ttm:agent="v1" itunes:key="L83"><span begin="02:51.252"
//                    end="02:51.540">내</span> <span begin="02:51.540" end="02:51.690">파</span><span begin="02:51.690"
//                    end="02:51.895">도</span><span begin="02:51.895" end="02:52.023">가</span> <span begin="02:52.023"
//                    end="02:52.156">널</span> <span begin="02:52.156" end="02:52.290">삼</span><span begin="02:52.290"
//                    end="02:52.515">키</span><span begin="02:52.515" end="02:52.827">듯</span><span begin="02:52.827"
//                    end="02:53.310">이</span></p>
//            <p begin="02:53.310" end="02:55.390" ttm:agent="v1" itunes:key="L84"><span begin="02:53.310"
//                    end="02:53.554">너</span><span begin="02:53.554" end="02:53.702">의</span> <span begin="02:53.702"
//                    end="02:53.915">맘</span><span begin="02:53.915" end="02:54.051">이</span> <span begin="02:54.051"
//                    end="02:54.194">나</span><span begin="02:54.194" end="02:54.324">를</span> <span begin="02:54.324"
//                    end="02:54.583">휘</span><span begin="02:54.583" end="02:54.835">감</span><span begin="02:54.835"
//                    end="02:55.390">지</span></p>
//            <p begin="02:55.390" end="02:57.983" ttm:agent="v1" itunes:key="L85"><span begin="02:55.390"
//                    end="02:55.642">Put</span> <span begin="02:55.642" end="02:55.795">your</span> <span
//                    begin="02:55.795" end="02:56.134">loving</span> <span begin="02:56.134" end="02:56.294">on</span>
//                <span begin="02:56.294" end="02:56.430">me</span> <span begin="02:56.430" end="02:56.682">night</span>
//                <span begin="02:56.682" end="02:56.938">and</span> <span begin="02:56.938" end="02:57.983">day</span>
//            </p>
//            <p begin="02:57.983" end="02:59.270" ttm:agent="v1" itunes:key="L86"><span begin="02:57.983"
//                    end="02:58.730">25/</span><span begin="02:58.730" end="02:59.270">8</span></p>
//            <p begin="02:59.538" end="03:01.590" ttm:agent="v1" itunes:key="L87"><span begin="02:59.538"
//                    end="02:59.776">손</span><span begin="02:59.776" end="02:59.955">끝</span><span begin="02:59.955"
//                    end="03:00.158">이</span> <span begin="03:00.158" end="03:00.286">널</span> <span begin="03:00.286"
//                    end="03:00.422">기</span><span begin="03:00.422" end="03:00.558">억</span><span begin="03:00.558"
//                    end="03:00.814">하</span><span begin="03:00.814" end="03:01.082">듯</span><span begin="03:01.082"
//                    end="03:01.590">이</span></p>
//            <p begin="03:01.590" end="03:03.642" ttm:agent="v1" itunes:key="L88"><span begin="03:01.590"
//                    end="03:01.838">손</span><span begin="03:01.838" end="03:01.990">길</span><span begin="03:01.990"
//                    end="03:02.202">에</span> <span begin="03:02.202" end="03:02.336">넌</span> <span begin="03:02.336"
//                    end="03:02.478">새</span><span begin="03:02.478" end="03:02.615">겨</span><span begin="03:02.615"
//                    end="03:02.859">진</span> <span begin="03:02.859" end="03:03.130">듯</span><span begin="03:03.130"
//                    end="03:03.642">이</span></p>
//            <p begin="03:03.642" end="03:05.542" ttm:agent="v1" itunes:key="L89"><span begin="03:03.642"
//                    end="03:03.874">Put</span> <span begin="03:03.874" end="03:04.034">your</span> <span
//                    begin="03:04.034" end="03:04.434">loving</span> <span begin="03:04.434" end="03:04.570">on</span>
//                <span begin="03:04.570" end="03:04.702">me</span> <span begin="03:04.702" end="03:04.963">night</span>
//                <span begin="03:04.963" end="03:05.215">and</span> <span begin="03:05.215" end="03:05.542">day</span>
//            </p>
//            <p begin="03:05.542" end="03:07.310" ttm:agent="v1" itunes:key="L90"><span begin="03:05.542"
//                    end="03:06.759">25/</span><span begin="03:06.759" end="03:07.310">8</span></p>
//            <p begin="03:07.310" end="03:09.810" ttm:agent="v2" itunes:key="L91"><span begin="03:07.310"
//                    end="03:09.810">Lyrics transcribed and synced by Akuro</span><span ttm:role="x-bg" begin="03:08.063"
//                    end="03:09.810"><span begin="03:08.063" end="03:09.810">(Twitter @itsmockup)</span></span></p>
//        </div>
//    </body>
//</tt>
